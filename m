Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A343458CB06
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 17:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243513AbiHHPHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 11:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235852AbiHHPHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 11:07:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BFC263B5
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 08:07:30 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 278ExJ1N024574;
        Mon, 8 Aug 2022 15:07:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=cZL8qpc/tlt7tsH4wb2V+X+/miEgvLR07fGTlEzjSuY=;
 b=hY9KPaLJVwvGBZ9wcc+opqHCBRUJY1nMrjA0+1gOsJAUdqHYhwSmC/fPobspuVuY6ciE
 Si4Mrv1UAdPEosu6IjT2SBFBsHW7egIA+EJHExfIjRVSL6TNgA7Zj7Tl4MjCtlFl0dmO
 elRnuebcKWFg8ym6YRB+lg72UIP8tZUNeDRusRwpALORED/BzBImJXp/mLJa5LT/h8dR
 DBMmNxI2eNGdjW3lpE4bMoOXqNYgxo9/4p7UGM1Jh6+ja3x5un4BkCwhkVZ/vGkS8hkD
 jMqf32bN0veOzHP0tAxvvqCOhsCDlk0SZxxkVQKQHHlJRdKJSI1hyd9hO5t/oiYaKY9N nQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hsfwsktfk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Aug 2022 15:07:09 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 278DXiEN012599;
        Mon, 8 Aug 2022 15:07:08 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hser825fb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Aug 2022 15:07:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l3dPszMT5X0vKD/F8Lqw/490FKGayW5mQ9Z+/TpSd5TKl1ek9qutLffC5PXWYGFskPSCjUvYMpqv2ZljSDc9A0EIyMUfB+kYubmj+F5MwH4Xw6uvkkfkPXRCD3igr1nZL+gxI2EA2f9SA9dEU8wNwa8TP0hmcX/kkrNN+paARNA+MgqapvgrGK1pzpGHPuKS65YipM5KOfBMXxif0/iUzl98nZLNRoL9Ea+C9eZWFJ/F+vOijb2MaFpoTekZzNi1yDhf0v7UZv51MoeNn2YYL/lcdbz0wpXpV5eNZhRDACfor+UG17TugXY+AC32oRMppNkbI8ae9Ge9D7bVYe6lXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cZL8qpc/tlt7tsH4wb2V+X+/miEgvLR07fGTlEzjSuY=;
 b=YHPRYu4mAqnNtguKMGeohC05u+ypsUFC2DqFD9IksU/SGBrB6YHf6Me+d9VZ5xwsqLYT3tsA/H5oXYN+LpJvnqAI3jRqw0J1prKMezMyIfmS5Kh8JjUlGIVJyH25XXIeEy3DgrYM2O81AtlD65YrSoYeUlzsgGuFLDC9yUofVI39U8AuoG44LWdmg0eUrUbaL6EPvGBfMRWCScKJuD51XLuwR4MReX7H83L4Aqt4KXIdCFMSuWJnnmf52id7Kadh2IkkMsqvNAHNi+6ZzvlFf/1IU8+91meDWbB4JUMar7uAelUVLhzM/MMJF8GA7ZRZOMXTsI6coPCNacVU24vM7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZL8qpc/tlt7tsH4wb2V+X+/miEgvLR07fGTlEzjSuY=;
 b=TX0sOMzJ6TMOEtxGytoQoSfXYHu9LjutDb9wzY/pJzzeE6QvKlXD0DqC8J4luw1+BucXfU5LxWRjKZEExvYT4euM3QOeOv5bpv3yMMtW1U9HbyQMWFEL2XeMdq2LDYxW3G32tQfTgdBp4Jyz4YY1q28Qd4dXhskSxStxjLqODLA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA2PR10MB4556.namprd10.prod.outlook.com (2603:10b6:806:119::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Mon, 8 Aug
 2022 15:07:06 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5504.020; Mon, 8 Aug 2022
 15:07:05 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hridya Valsaraju <hridya@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Todd Kjos <tkjos@android.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        =?iso-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>,
        Carlos Llamas <cmllamas@google.com>
Subject: Re: Binder regression caused by commit a43cfc87caaf
Thread-Topic: Binder regression caused by commit a43cfc87caaf
Thread-Index: AQHYqw+ISmpRZPmLpkiane2Iritf5K2lGuGA
Date:   Mon, 8 Aug 2022 15:07:05 +0000
Message-ID: <20220808150657.liop7yf5hsutbpp3@revolver>
References: <CAFqZXNtNjQLpzu4CFiMawfkKeVFULw4ti3MdZL1QejPrzeJv8Q@mail.gmail.com>
In-Reply-To: <CAFqZXNtNjQLpzu4CFiMawfkKeVFULw4ti3MdZL1QejPrzeJv8Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2573777c-60db-48f5-f46f-08da794fa822
x-ms-traffictypediagnostic: SA2PR10MB4556:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /an1lU7OfC/clHPudl/tfcLO8mvd/xXMHvDa8MyYJStnC0iRs0ETVmXpXE0HbohVugZ7J2ldmgBOb+qJNtgGZahD1J0U4FmNqwt8SQ+T/Y42jRWBFOl1JNJ88libfpOWeW0i11JwJCRrF98XAWPduGQb9JXgksRK3yxriyyFCaQGZt7+xo23tWhzwL9jc/rUNH4R9gIycxHpjV5RA3Wf2nilSMgGO0IHUGul2skCXM+qQWL42AJb8lb+E07BVzMGwHG4vGf9e25iaE4wNNm+BOv+KH6G2/C3eE1X4xmWrQeQN/zPmV+QpoOp0h576NbOiO71GXYR//m6PdCSDMGYMxNyaYonzlThr4/BQ8eRn5M4qiGvek1LTBrG1p59dnOHk7trPdpfQzQ01ajUu/qs+XUsu46DpFHSRAVXfgHL9N1aheayA+BRK+QKiF6uG8MdQcktZTxNRYgDSsiuVvYZJFwSY1Zsfkehtki7SGPE5nRC2R0q+1KuHrOePw+ZpeCD0BdjJr7J6/25BbIb/nrcMgFp2EWJQ/JDprsOSTfoOl/znaCnAzx7sFGMnR1FtKgNqgNDu/upziYgY8DNZI457PxfTZRVy0Bdj2sYOzdOMOWsZSLf5CIv+aN5pIHAoWcTTrdPuK8Bwblj9XqZJgVclq4cEgQFF2WSmjg71J9C1+tc/ggXbWyZXKLe33ROHRmC5FC9yr7SuIQIJe3liDd9mhckDZqO0nrJgJs291AAqmL4AemPTCvBCvrhdiPpUsKqB+Si9l006AeMbzos3GsxA+F9cQmMj0VnjLSJ4bzV5zm3/Uy6LYerZVK7/nNMCCdzbI9LCySfZqM/lgV8nFFnN9rUOmTrgofkB6+Fply3+4Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(376002)(396003)(346002)(39860400002)(366004)(2906002)(26005)(6916009)(316002)(9686003)(186003)(71200400001)(41300700001)(6512007)(6506007)(83380400001)(1076003)(86362001)(54906003)(6486002)(966005)(66556008)(91956017)(7416002)(8936002)(44832011)(122000001)(66946007)(66476007)(76116006)(5660300002)(66446008)(478600001)(64756008)(4326008)(38100700002)(33716001)(8676002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?DoGCxBGBOXDBHeKqha7uXg8T14lSVRdy0HWMGvvjMQdSadU7pgISKaVO4a?=
 =?iso-8859-1?Q?nMzhjtTMZSRyq/W3MlTzufdB1v++UMwFiyQRerdfO/EZahTTxubffq9Qeo?=
 =?iso-8859-1?Q?EUo2XZ4gbWzkWzDnJtW7C/8FdKtRCoqtWi4ZUwbB/Zr2eOFvA+q5nEFj+l?=
 =?iso-8859-1?Q?K9+H1Q780mwKGxFYiRsr50tmKjvXObOVWItieWankvfBh1GUHR5YQuNDWW?=
 =?iso-8859-1?Q?Jg62HiQNZ0gnBJspgHnrtMSMFUmsBvEV3TjOt+7POH6YU2Lceyj3WvNGQo?=
 =?iso-8859-1?Q?cWeKusdFlve5KuHD2Ij9Yup0BNtzlYRUpS7sVaBTSiAEFtdzg1ZwIthC38?=
 =?iso-8859-1?Q?JFz8tMTYM6/5X9y+FfEvuon6mIIYONmyTAlfcFXhdMgevZpf5ZIQvmSsVX?=
 =?iso-8859-1?Q?czBBL8PvYjE7+D38kSxJFszRcogILvQCapqVKycDN9kD8pheaofOrnoZ4B?=
 =?iso-8859-1?Q?PucF9Sy+ankM3p70qcgayvAcB2FKx75cxZWg080rmrjzhaiisr8+tJkEWu?=
 =?iso-8859-1?Q?KT6+4ioOJu82fzwF4e9i6t9Z1dOHzGRIn3IgrwyEnHnhcrYpztShAGOY/O?=
 =?iso-8859-1?Q?0FPaUStjaXjEWRPg3rit0LWdMvrv12Zt4750nvysBBZgoDA1C7BMa3/77c?=
 =?iso-8859-1?Q?r8Oze3XhLImeGalmSo/Fybx/Qy4R08bGEyQiPEVHtUSlaUsCgfe64k7qmG?=
 =?iso-8859-1?Q?+axXTEo89zqXz5syn0Z5sg/l/7vIWR/T4TeSFblYGXruv/h0TZv45JmUL1?=
 =?iso-8859-1?Q?zdtb7Dh7zCcIHmFiWtsJj0LSsiJSibLDlnvqU15Km/EKABMCVuFlocGlcB?=
 =?iso-8859-1?Q?U9XOcr0YObyOoBbow72F6V4DQ18YoKCaZUvytt5nTeRp2050eBz+SAgmuY?=
 =?iso-8859-1?Q?GNHAdeVXa5gZPTVeeMt77S/A1csceQxJYF0hbogMnsrLk+ZXpdzDwuq+fk?=
 =?iso-8859-1?Q?wrHkDLrsxALwN66bvSa54nktvPXxxq8btN7789vK/u+rvSBxS3ua9zoNH3?=
 =?iso-8859-1?Q?LTDeWiMmv25sftxPqdVTgskjlglGatpfdxIdDHNNl/QQH9K937JjtQwtck?=
 =?iso-8859-1?Q?2FK+p8TGUEO/FKjTj7yUi4FGCzBlp1GRmNBSSAN9gGKol6xEQVUuIeqsBj?=
 =?iso-8859-1?Q?I43YBOlJJ/laxSJyT1GHgeWxHEIs49vbBNL8eSBHID8HcDndlTzE4A5BOc?=
 =?iso-8859-1?Q?Sm6vWezu88HzOUxl0MVz714ttXgV1PXBocDaFJA9oGMy0p3JpuG/YROVJ1?=
 =?iso-8859-1?Q?3R/wNpJkuadqwKuOVLnkhp6WyE8YrH8t3KI9tDfA91weyu7bi+F4sI4Qui?=
 =?iso-8859-1?Q?Zpjl42j+ck1BlupA5OlpGGra1TC1o33GAyHaPTPgn29WIT1adDqpnANFGa?=
 =?iso-8859-1?Q?DXjys/GLBg2BRQ+8zuKOhsrPUAAHqlmUzfm/b3mHDwa92Qw/JcW5J7YGz+?=
 =?iso-8859-1?Q?Rk2sONAOxQoJhN1RV8L4weX0vhnxUmv3vRJiyZ4544I8D6tcV+bbMxnpCu?=
 =?iso-8859-1?Q?u6VLjmX9eR3v12OwrY9xN23HdpqpSaKyd1N9WHSMeTTOrycRZddQXOaNnL?=
 =?iso-8859-1?Q?wIL6tlbFbezKVKAkDqgFgQS1MLyNdfcvPhJbOq5wrR5B/sCfqMbaFCbKPT?=
 =?iso-8859-1?Q?VWhkyeUR3stB9iVmCaCv8/ZTA8JRcU02gP8GQeFeEfqdTnOjsxFYjthA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <2A66C9C8B2206F46A4B3EF2536041487@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2573777c-60db-48f5-f46f-08da794fa822
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2022 15:07:05.6430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rrh1RrJeiKKQ0aC/UTj9cycrfrSqTKABPPjnWmiatAG6cUTsm/bqs387IGZNJK44OA9zezViP/gNrzEDWDxZXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4556
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-08_10,2022-08-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208080073
X-Proofpoint-ORIG-GUID: NTUsi82EKfXh3Siwk9xJJEpsuUGGPehU
X-Proofpoint-GUID: NTUsi82EKfXh3Siwk9xJJEpsuUGGPehU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Ondrej Mosnacek <omosnace@redhat.com> [220808 06:13]:
> Hello,
>=20
> FYI, since commit a43cfc87caaf ("android: binder: stop saving a
> pointer to the VMA") (found by git bisect) the binder test in
> selinux-testsuite [1] started to trigger a lockdep assert BUG() in
> find_vma() - see the end of [2] for an example.
>=20
> A minimal reproducer is:
> ```
> git clone https://github.com/SELinuxProject/selinux-testsuite.git
> cd selinux-testsuite/tests/binder
> make
> setenforce 0  # if SELinux is enabled
> ./init_binder.sh || true
> ./manager -n -v & sleep 2
> ./service_provider -n -v
> ```
> Requires the equivalent of libselinux-devel, make, gcc, and git-core
> Fedora packages.
> The last command will trigger the BUG; on good kernels it will
> successfully enter the ioctl loop.
>=20
> [1] https://github.com/SELinuxProject/selinux-testsuite/
> [2] https://s3.us-east-1.amazonaws.com/arr-cki-prod-datawarehouse-public/=
datawarehouse-public/2022/08/07/redhat:606549366/build_x86_64_redhat:606549=
366_x86_64/tests/5/results_0001/console.log/console.log
>=20

Thanks.  It looks like binder has some paths that are not taking the
necessary mmap lock for using VMAs.  I'm looking into it now.

Regards,
Liam
