Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9C34AB3DE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 07:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348894AbiBGFwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 00:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239197AbiBGFjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 00:39:14 -0500
X-Greylist: delayed 3081 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 21:39:13 PST
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9194BC043181;
        Sun,  6 Feb 2022 21:39:13 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 216Mp8Mm022472;
        Sun, 6 Feb 2022 20:47:49 -0800
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3e1smr47tm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Feb 2022 20:47:49 -0800
Received: from m0045851.ppops.net (m0045851.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2174jBUL028894;
        Sun, 6 Feb 2022 20:47:48 -0800
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2046.outbound.protection.outlook.com [104.47.73.46])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3e1smr47th-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Feb 2022 20:47:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JUs2m6hIE23g5bJzka/bov+EeNKLh17NnE3lnnXCAUVu9C9+bg/RPxQo8htFl8EX+F6omlaEcoIl44rV2ayCj3xICEJrStv2e03y07FSsILrgFGOGaje64KvaWGpEiCJHZvIBTJyZPJjbV1L24NOh1TN5sqA0bgHhJRRlqA495pf05Sfz6TLaH4LMLoYq+kg9drGXjy7pWfXBSG1z/WEWMepTh3veUssrlDPGa8Fh+kSgc7LYHLnUanLe1i9XmLlNc0y+aIZoM4aFOOBNx1Rzr0i+ikUwWh8TeWN9WbN8Jvv1OA8/4Ge5bdV998oKx6oCTvGy5DYG8PWTNoMVSe8VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q1frTVwXcftag1/pD3pLmLsICaz8uPGfhCwXbxr63ks=;
 b=ffeXje0Z3CFqHTjA5TQ590xj6GYn/cwZ2jzIjkz6jcpFabPkD4NjqkzRS+LeUEdq2lWYl6F8LzqEclKlUliaIR4BPBW4Tq52ydC3thlXlFtn3/6BbQdxXcb1GsewpWzDtIoWLvvNofK2Rw2jHgl2v+eS5Q5/F0mF6z2aEb376vFzLkXMbMaxaYt4JlqrC3e19vxUgvy0s8T6PNZTLIm3cxAxx4Kv8A7VmLP3iMuhT3y8hn/IIfJl+dQaajHRhLOL2BSz2YWSB7p87yiI96bKuIwgiIb5nDGM9uoxEaqB8+RrXx873A0h2+f1QJg/blotnhQH7f6ywrZv3UVfrS3U1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1frTVwXcftag1/pD3pLmLsICaz8uPGfhCwXbxr63ks=;
 b=AY6aw3HPmYWacrPN1nRPx8uaSMgRlSCeHWm4XLwUfQyfQM3WPeosElu7a58i68jt+8pT7RSFK5/4sf75xpLqIdLYWNfYamPQODBEsgT5aDdMqAtPFRSPhqH2YlzygeuWZOU6K7FZz6E3dk62w87nWTWIr9xNfA9tJhg/59eGz0w=
Received: from CO6PR18MB4419.namprd18.prod.outlook.com (2603:10b6:5:35a::11)
 by BN8PR18MB2980.namprd18.prod.outlook.com (2603:10b6:408:aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Mon, 7 Feb
 2022 04:47:44 +0000
Received: from CO6PR18MB4419.namprd18.prod.outlook.com
 ([fe80::6472:ed96:1810:fd81]) by CO6PR18MB4419.namprd18.prod.outlook.com
 ([fe80::6472:ed96:1810:fd81%6]) with mapi id 15.20.4951.018; Mon, 7 Feb 2022
 04:47:44 +0000
From:   Manish Rangankar <mrangankar@marvell.com>
To:     "cgel.zte@gmail.com" <cgel.zte@gmail.com>
CC:     GR-QLogic-Storage-Upstream <GR-QLogic-Storage-Upstream@marvell.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Minghao Chi (CGEL ZTE)" <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: RE: [EXT] [PATCH] qedi: Remove redundant 'flush_workqueue()' calls
Thread-Topic: [EXT] [PATCH] qedi: Remove redundant 'flush_workqueue()' calls
Thread-Index: AQHYEx7EPHJ+6QFA9kGxpHb8JUgdpqyHlQDQ
Date:   Mon, 7 Feb 2022 04:47:44 +0000
Message-ID: <CO6PR18MB44195156F85CBE435DA1D5A3D82C9@CO6PR18MB4419.namprd18.prod.outlook.com>
References: <20220127013934.1184923-1-chi.minghao@zte.com.cn>
In-Reply-To: <20220127013934.1184923-1-chi.minghao@zte.com.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9fbc3a28-f229-4edb-23e7-08d9e9f4fb1e
x-ms-traffictypediagnostic: BN8PR18MB2980:EE_
x-microsoft-antispam-prvs: <BN8PR18MB2980DADE79396C43B8711E41D82C9@BN8PR18MB2980.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:339;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cacw2HOTb7Wbvzcu0RdU/xxxwxqcIB/khczQzTV3Zay+eH3UVBDCe5FocVr/6xfrX98NrvEkStD+OOPE4s/+9S+VvE5rfoBf7P2T2+2EqFXvVBDj7YhCenugztMLja/ZouKTf1XFGsVWTEFcDkYnX/97x5jSyuZvI6J29LJ+KltKxsTC16kC8E8PRxU9zTIP4o+AusE9EGIYQsFG0XzQisDspOOkS+lsQKQ4wFjKJLns871iZm1yf6sUyq2XXZ4HsIDNz1rPxYVUEkzvOW0sExo1TGTnq97JvxNDD5ZCfc1EIIY5fzbRpLAJhEjY52vrBoY6+oDS3MRq9Gnlw01KSRR+IAoqyUflQ1UqnNI5NfUrvXnS1zr+90lHmhiurNHPj+r/tzbXGvsODrc2cTWAPWQu4BFkpUSvU17eeXxw3QqQRFQ/Q/FuzjeP4RkuqENWFQYs8NlhJj1y5T/ATfZc5ORcpsEuzMIi63dYmMNDT0ULczlIiXFV6j/2KlBGTZ4DeXMzQvjS7mN/GsGhdEJbnjqsTjT0mlL8A3YKpdclNAvlWyYGF7Ze4tl3z5S5ssQowKGeIYviwwWeUz1I9wSEi6leDhhNZm9QaDdl7C3yxyAetYAEw6k+BFiqBYeh/uCoyZ1ufzEyxdnYlhC+rQpPKRcsQYvhxI4BHoK165fMy54dvTBffyiv6/U487rJ0IvF8b+EL6toTPqFcXEUlSxJfQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR18MB4419.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(508600001)(316002)(38100700002)(6916009)(26005)(38070700005)(54906003)(186003)(86362001)(76116006)(52536014)(66946007)(33656002)(5660300002)(6506007)(66476007)(66446008)(7696005)(64756008)(66556008)(2906002)(9686003)(55016003)(71200400001)(53546011)(55236004)(4326008)(122000001)(8676002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?me+a5XRz/lWHydhmz0/5m0QIV8nZCUHKzBaLBI1xV9JYcelgspOsxKggCE27?=
 =?us-ascii?Q?kp52t6kVQCYdR/Th0x6LaJjmohdKooj4P7w+VKYvLmacZX4qFUxxek7KyPVH?=
 =?us-ascii?Q?xWQg6e16B0YIFuL1EPMTprRRfpTtse5QndmHEre4CXnBc5+/vKwzN9X4Dj8b?=
 =?us-ascii?Q?4BES0v++/HJLNPAh6Gou386Fmjt0hwxfTUpHsZMTNmC8WeyTWWJeBdHCD6jB?=
 =?us-ascii?Q?sX5mGmfQ90Ehna2qTWdLuFPxRjo0eMttW8tt7DR+Le4ky20TZ+VF0paxzQt/?=
 =?us-ascii?Q?M2K+C4cYC+Ro2/iS3WIxFkIPx4Ny414BjysVsXds/MJ/J6q11ch1cbjg70xX?=
 =?us-ascii?Q?DhY++5vwD6VxZ+FT6X6Jz3irZiKsK14gBKh/rJxgWmBLHEyRXniKOoLbscv0?=
 =?us-ascii?Q?IgixARtr8fhumuxMiw0pjsPNs/yDro1W6qZR5mRq5hYPW34m192U9LhL+0rQ?=
 =?us-ascii?Q?E1Q1CP54Qujb30cQ4NAREC58ZDtACtRBmgHbPpUSuLD4KSH0hQWTxsg6OXTO?=
 =?us-ascii?Q?uJxvaN980oq8iQm2Di7iHviulwaWJIB5ZGCyXTu6aVlSgRLbAJ5zwhexeWp3?=
 =?us-ascii?Q?fF9kv1T8WFJpybzdxFwEkPgwVFMHJIDGRA3xvwb0LE+XGY+d64HY+/cjHRo1?=
 =?us-ascii?Q?D9p2xFaduxRpa/PSMbY8YH37uhGVHBfPZ5bznGhyW4sZHw4BgYY9P/MdmEeJ?=
 =?us-ascii?Q?78QzBWmsoOGziejnWt3lhGSYnpXSt5oyx0Whmbwk7u1+XgkY7iNSHQhqSy6O?=
 =?us-ascii?Q?MSWOFNhBzsMQoZmE9daVopIBs0hK94BiQK25Xsuh/kN5/XP96XKIv1DeJE3R?=
 =?us-ascii?Q?Tweqvg+BOpW5msu2Rt9g2VRD8yTCdNznKrsorGIThYJP9/eYzZOOiybfb6V4?=
 =?us-ascii?Q?FftCCRXjRbR9XT1AU0VtXBbnjWLCREl0kavFfzh5+bl9O4gW91Jk9mU0ioDm?=
 =?us-ascii?Q?kixaWyKy0HYLisNEeXu54f2wDvaFcXDg7jOI+ZL0CrffUS82Rmq7XAZTAAoF?=
 =?us-ascii?Q?+X4jY3Wn6yBeeleyjS6aBCy8ak2aBUzpCvE9oziv6FJX2yZFoudXOX0WLHgn?=
 =?us-ascii?Q?s3VJyCrLqkfAX4Y8mlNKwPm8ep7EunM4cgqmGgQVuws2IEHHxDbLPtzUzC6Q?=
 =?us-ascii?Q?EME2BFDy6uVAs0CdY4QjVQSjU2XwVOOucLB7uhqccVBZatbDomzV/kfld6eR?=
 =?us-ascii?Q?LdKHTTr0go35rjF+ChSz9wFVcPxdVxfo7TSXRc6vA7WQYoUKWKALkeMOEQXp?=
 =?us-ascii?Q?FUvTA5oLObD+al86l0ftiS/IMgYPwi/jsexHk4Nc4e7ZKkG/NY7TLlOMOhGy?=
 =?us-ascii?Q?gW7LYKkD69q5lFGTt1FxnDvEWv1a4jmjFHS6EJ0vnIkH0UD2SrrpE5Rr2lsS?=
 =?us-ascii?Q?WeQrkZBZrqDWnH6HpzqYiSJhuKQGNEHrPrUdsf5xdF6s8dHPZ6wuxHO0FWrD?=
 =?us-ascii?Q?fNeSLcueEGG+Qy2Ka0ubSouxWBxQUUSrWCUu9TQIRWjsRWPQYDAq3Cyj9TmM?=
 =?us-ascii?Q?eWhmDg4Wld1azZW12EsIDtarqDxbd+vHpKVBo1ZLpOH+JjidKyFBmOS4o0Cw?=
 =?us-ascii?Q?CB1ubDfM0lN0dIUqKGuwtFjOLLPx6j48bTUYa5BZ9mYRW0CT6CjVmJQeXgcd?=
 =?us-ascii?Q?ueNgSH4Ww4JjpKXIl6IKRCs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4419.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fbc3a28-f229-4edb-23e7-08d9e9f4fb1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2022 04:47:44.2891
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7jNzwz4W5EIG+7cb3a1pmKDAt1nBv4/Rg0qzyA0UgDAX8XI6iAj2zRrD/e994aPaykKuiGWCi/1FOUnGETtmDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR18MB2980
X-Proofpoint-GUID: 86zgT3TPoaStq5cz_qoXbin27gVwmyjs
X-Proofpoint-ORIG-GUID: xaPvZX3EBdhKnsYOreNB4xemkJ2pPpmO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-07_01,2022-02-03_01,2021-12-02_01
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: cgel.zte@gmail.com <cgel.zte@gmail.com>
> Sent: Thursday, January 27, 2022 7:10 AM
> To: Nilesh Javali <njavali@marvell.com>
> Cc: Manish Rangankar <mrangankar@marvell.com>; GR-QLogic-Storage-
> Upstream <GR-QLogic-Storage-Upstream@marvell.com>; jejb@linux.ibm.com;
> martin.petersen@oracle.com; linux-scsi@vger.kernel.org; linux-
> kernel@vger.kernel.org; Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>;
> Zeal Robot <zealci@zte.com.cn>; CGEL ZTE <cgel.zte@gmail.com>
> Subject: [EXT] [PATCH] qedi: Remove redundant 'flush_workqueue()' calls
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> From: "Minghao Chi (CGEL ZTE)" <chi.minghao@zte.com.cn>
>=20
> 'destroy_workqueue()' already drains the queue before destroying it, so t=
here is
> no need to flush it explicitly.
>=20
> Remove the redundant 'flush_workqueue()' calls.
>=20
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
> Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
> ---
>  drivers/scsi/qedi/qedi_main.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/scsi/qedi/qedi_main.c b/drivers/scsi/qedi/qedi_main.=
c index
> 832a856dd367..83ffba7f51da 100644
> --- a/drivers/scsi/qedi/qedi_main.c
> +++ b/drivers/scsi/qedi/qedi_main.c
> @@ -2418,13 +2418,11 @@ static void __qedi_remove(struct pci_dev *pdev,
> int mode)
>  		iscsi_host_remove(qedi->shost);
>=20
>  		if (qedi->tmf_thread) {
> -			flush_workqueue(qedi->tmf_thread);
>  			destroy_workqueue(qedi->tmf_thread);
>  			qedi->tmf_thread =3D NULL;
>  		}
>=20
>  		if (qedi->offload_thread) {
> -			flush_workqueue(qedi->offload_thread);
>  			destroy_workqueue(qedi->offload_thread);
>  			qedi->offload_thread =3D NULL;
>  		}

Thanks,

Acked-by: Manish Rangankar <mrangankar@marvell.com>
