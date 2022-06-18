Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6CA15501A9
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 03:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233669AbiFRB3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 21:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiFRB27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 21:28:59 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC5536B78
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 18:28:57 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25HLtxuw029748;
        Sat, 18 Jun 2022 01:28:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=9X49wO4hq0KnClMeQ1pmnvhYaqiRCu9drScKmJhNAIU=;
 b=ilrA8ij+SFzr2h8WH6gCLAUTGyDtvssoFAe6ailctQVDV3Uh2Xdbkv0ICzPDqn3ck+xJ
 rIm/MkiFdeXR67GP3dRyYksgBMSsFAsVT+1myTj5acWYvHAlxdpU4OQVpxgBbJXoLrbx
 icBeTaKWTIMyaD35v1InU9krElk5/RBKMq90XkcymZpjOEtz4J+Hy0ocgwI5ptmIan1g
 RchERWE6vejvuInW9XAuh71Ova6Jb5t7/Au87fokS8YP2rHnuU1oijh7qDv75NkE7b0k
 ap0rbomHq+QINTKgyjy3V42M1ehbmXRbVz52B1opBDObXrtsgBwE6EV/f15FYxS8e0/w 1g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmjx9pnba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 Jun 2022 01:28:55 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25I1GAGK027481;
        Sat, 18 Jun 2022 01:28:54 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2046.outbound.protection.outlook.com [104.47.51.46])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gpr7s34nh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 Jun 2022 01:28:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YRApkiEbHmO61ITEnXXfmA+DWg7AVyHffprYG3xiJY5FH5LMtlsX1DOfh1Wp0GfEPAM9WWOzawEGpoD2EReWr7dcGlnBqHmIVKCGgQaShnfKUCYcPtzKxfrAUqfVSKo9u/hlMZfzZPF8Xv4FH+vaij0T2apJsW3N9PuOhYiLeZZCezs5aWxEvbr/ft1CJBOuyMybGunNWjWpktQT+rIfGMiCc9w6KlU2I/zaZYK6yTePCfBa6sHEW0goQnAXIHldpYp9VC8GP+ME1nH4PLrAAZ5ilDLdSy0tk+cLS5YjjtkbQae95xCPMrCiXHmdvLRseQXdxKpQEQIe+KbexKYULA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9X49wO4hq0KnClMeQ1pmnvhYaqiRCu9drScKmJhNAIU=;
 b=BDoGebd5lhXWZuORtxZDcop8S4exTdxopqbC68b2sv42lLQ9vTmxDOweCDz6VsGwEInFNOHhmU7iCPJ8GKdFDbhHPE70S2up3HW/BbDLy7yxvoFgGws6bif6uIF8HBTtehjCglYX4H4LdO6/QfDmGi+BgsaynH3+e8YwXllHeNPZ/+R/xjfCOXTAWt7gMIz8ex5PPWvawTyY+qJpmXqXFcguF/YAR0fpG+xxzx28LzWvyvxX/fdfKwfCbD0aApxwdXtPiYf/DQfD39lncXg6w5LI5JPud06YUFBmAU2xVJbpLFww8YtnaDxlKPo5tHuuESU70REIhySLClKYvdiBGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9X49wO4hq0KnClMeQ1pmnvhYaqiRCu9drScKmJhNAIU=;
 b=rCi6XioBweK1PNNwSelmD8I4pt4bn2zv7rZePl9RjIjTMWBrT80RXQiKdEUvcTTKkCnkJq3/9TFTcDRR2Mn3XFPb3ApcQt3Lv/i95RcmEcANNLnUU3mFOXcb0aEkKLU1vO02IlhpnIu9f0IaYXbqhHKJaFpAbOLTHUF+ovAQxPk=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by BN8PR10MB3491.namprd10.prod.outlook.com (2603:10b6:408:bd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Sat, 18 Jun
 2022 01:28:51 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::a47b:b68e:57c0:7b31]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::a47b:b68e:57c0:7b31%8]) with mapi id 15.20.5353.018; Sat, 18 Jun 2022
 01:28:49 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: possible trace_printk() bug in v5.19-rc1
Thread-Topic: possible trace_printk() bug in v5.19-rc1
Thread-Index: AQHYgZTiaV2APa8LiECz6bYrBgXq161SKdYAgAAAwoCAAdkwgIAAXpIA
Date:   Sat, 18 Jun 2022 01:28:49 +0000
Message-ID: <3BAD2CD9-3A34-4140-A28C-0FE798B83C41@oracle.com>
References: <F6C267B0-83EA-4151-A4EC-44482AC52C59@oracle.com>
 <20220616113400.15335d91@gandalf.local.home>
 <E309A098-DA06-490D-A75C-E6295C2987B9@oracle.com>
 <20220617155019.373adda7@gandalf.local.home>
In-Reply-To: <20220617155019.373adda7@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 405853ae-ca7e-4b66-575f-08da50c9e541
x-ms-traffictypediagnostic: BN8PR10MB3491:EE_
x-microsoft-antispam-prvs: <BN8PR10MB34917FF338BB9853B16A4F3093AE9@BN8PR10MB3491.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EqZG5YfmErluYwTnDMNQ5FlCjn/mKPHKFwqiRGT6+F8aZgjJgz8rg5898Yk18CyJkrGJ9O7R9MIuhoB1UZMQK/xqvX/fj4fa2Ou8PCpw34Q758qGY4Ke0SfbsoTSHv041FHNVGntCSIe/+pANeH+gYdFpL6zOacucW9UBCe3n23BIBFkY5LIKt2S05zcSdF63qXBXEB3o/CcmuAkVsvB6Hj6+vAPeDAUI/bM1FTGJFVa2dyuO/LO+PJPmRF/6EIkw9XFW3aCDRCO7U9YqKy3kfmJQZXl5elMipXrGgp4DexzCuCWwnFfDUgaLvObl0bo6R0W14mWRbOGqXohVloI3lK6Url0MX0eurgsN4asxVvg05ZZDNHGoBngdk8SP2o9HgVuIWKLBt71Uvm6BmNVCAe1nBwLZyzY6MjKNHtxSzXI436KUunC58yxVz43pE9I+dlWnn9PclhJk4ExLCrscGIX/nS0Ykxt7pYh6KwtY0wkU3g5VdgGOtgemo9pR0PCWC+NXiIBYYtNHS3d32C8ul53Mmz4SAQkQoSO6BAmmB8DZWW9eowsAhT0bzZY/9D8zgY3VX3UhGifMJEOTRNhr3JPJyTt5iBj1xYRXsoqb7nt8eFiBDlHMkEibwcYI45+MxBdZUkHdE/VsWm9/p56H8IBisn27jy93Ox3t8Jt2wkz3bW1vdafkKk8mY4w9k81r3GKOAluQwPanCFeFbHkP3nQC0npQgkOisjWCT1GpcuSvg8OY1npo11mXaViAK6c
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(33656002)(86362001)(122000001)(4326008)(66556008)(5660300002)(83380400001)(26005)(36756003)(2616005)(38070700005)(53546011)(186003)(6506007)(2906002)(38100700002)(6512007)(71200400001)(8936002)(6486002)(64756008)(76116006)(66946007)(6916009)(498600001)(316002)(91956017)(8676002)(66476007)(66446008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?33wk8ME0M7hhYCdQJfDblhi2UwWY/WOMiYXmlYbWkgoiAS+fCNT+IiQIMsM3?=
 =?us-ascii?Q?uTEcCfZfALqh/00+kLz07ez+u56fk4hoB0mH+eiYHNY0mBbkQMX1hXX8M66O?=
 =?us-ascii?Q?YBb98RhaMGjf3GSzEkQfdlgrjbDc/NEErlitBvbbTxG6zBHRhjuBSjLw39Yw?=
 =?us-ascii?Q?LGO0s8rI+VC7J3w/ldv66SOTeDXjAbHlXYswIFxLca0NPj47Ah1Q1p9cnKn/?=
 =?us-ascii?Q?WdNNDFQGSseg5cx5/7RrkGD6k6gBTkSm0NYtXom85gWIg8Nn3zP85lRv123h?=
 =?us-ascii?Q?L0FtJbErTR6/pxn6jzUwtyXq7Ao7ve/DtuOwd4L76aLnbvQfHwOg10CsoCP5?=
 =?us-ascii?Q?homa50bf05x9tujsjzJ1oWsAt1xzSWm43KE+kP1TtsFAO2fC6vmDYHlB7dIk?=
 =?us-ascii?Q?t2CTsibEW6ZW4YNcMLlsMC07nZynHa8qSt1OyGPQCapqbiCUk7PbEfycpjS4?=
 =?us-ascii?Q?fPak9v8gVc8bpLp2CxGHvK+s/VKAcMLY4MUi381Pcx3QyAVYt3qTYpUVc1XA?=
 =?us-ascii?Q?S3c3hF9hp0GxmDljRN218fw2vv9KNe7vazZrKgv/RFCjJXWrswLvN9FScOkD?=
 =?us-ascii?Q?tytfD8ItuF5v5h3S8wZRJbt1uu8gQieM5FCUXxllHEzsk1MljldLI3NK7o93?=
 =?us-ascii?Q?ybr0omvS11HaVzRIlb8Yapco9IML3aFXekWj+H0TXvyUXyj9Z1WLZEhAmP6c?=
 =?us-ascii?Q?0/M9inpsAscPgEJRvXrnSFda4bJQLPhhxaW81H2X7bexS1pIDzdx76u6gC6j?=
 =?us-ascii?Q?0ixXthrXNqVelUYXysJ+14clvQmI4yy62kDtLjOP8qPKIThs/Vdt4+VC5yeJ?=
 =?us-ascii?Q?roOLbcuiOlcfQ8RRLgLfDFjiaDEMnVYDryt4zajcjS9rUp0o4n/p8PotGN08?=
 =?us-ascii?Q?p2IP71K/sHAGCiStCO+Lrr0hUfNIRKjd7EAAfjskJ1PWqQ49hVFbOi6ftsUo?=
 =?us-ascii?Q?Gmui5H263S0HWK2FYT+ddtSONq6C9VLVlzdgDYyUA4LJwFiR53g6VU0wNfnJ?=
 =?us-ascii?Q?UG+sB/+s477UPfuy1/w0bRcmV9pOPLlMmav+5HUgiBNPFy2HEGa8sOkxG4UR?=
 =?us-ascii?Q?hWMNC7tQLB2SrMxA2qQZaw5yXs880yoNfmr1AYyjkQJGf1TtqSX8ph4cboEv?=
 =?us-ascii?Q?EQFLTlbLusZGTaSI6TQ1UQ3pmJIMEBqnCnUqQJ9cSHutV514IU4pCvXS7SiS?=
 =?us-ascii?Q?w8v6rJA1k4vOYCSpkb0fX1gpwb4sB0SZEixbsBME8Pk2VolMSmD948UAAd/u?=
 =?us-ascii?Q?pmnjyUCVg35AXOsvV571psgK4DLIV1Z55eAwmxc410jLiFfQDiJg2VuOhoLn?=
 =?us-ascii?Q?hMW7dlf9TDGKYHdN9oDa+cLH2CNr7MSykZ+LuYMafoqFJXKBlO2d2FTwObNf?=
 =?us-ascii?Q?fmCqF+1p/OLtBPYhSfq/LryKAUqhUy4FdQ+4OzyrqirgM3qdtyTCtsLsl9fd?=
 =?us-ascii?Q?MuBnrlvwFXQ2zezxookW3XayVS8Dh25Aw7QXyW8PjGb0mb2IL3mVyeTlWoWC?=
 =?us-ascii?Q?41xXUFmfRlYJVTtNaPY6w6Yvk6iP/GQvdzWPEvTsM41bpZko/k0K52/wfD9Q?=
 =?us-ascii?Q?ZchWB5E+wYhGEaDuWnUkIC/ArzwVXxsItJspm8wQG2iiEByNsCneml/VNcVN?=
 =?us-ascii?Q?dGIwdKHPvupbhbnuR0wyp94vnrHpi9Jtp5I7CUniHi7/iC7nzDThT/eUpbVC?=
 =?us-ascii?Q?zbOdwzADZj9xEgMg3sIvTNdhD9UVnEdoLOW0O7v9INK6/t65NfDBbqTJRomy?=
 =?us-ascii?Q?Dx/q5sMfBpLHHvmPmmjwBYniels058Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <73C825C369E84642B65BD6B6139AFE54@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 405853ae-ca7e-4b66-575f-08da50c9e541
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2022 01:28:49.1103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LokXBZfTpgNs4YlKYdFtRkvN8+RUu4K+nYXngDDNeQqjjiZZitP9ZmQ6/zZAAtKNgX8vg6FNmqPzUBETpo2yzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3491
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-17_13:2022-06-17,2022-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206180005
X-Proofpoint-ORIG-GUID: GphO1s_2I1X3suRC6yA4xVHy1IDGCFWC
X-Proofpoint-GUID: GphO1s_2I1X3suRC6yA4xVHy1IDGCFWC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 17, 2022, at 3:50 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
> On Thu, 16 Jun 2022 15:36:43 +0000
> Chuck Lever III <chuck.lever@oracle.com> wrote:
>=20
>>> Did you remove any modules before displaying the trace? =20
>>=20
>> I haven't explicitly removed nfsd.ko, and lsmod says it's still there.
>> And, trace_printk was working as expected on v5.18.
>=20
> Are you sure?

Yes, I'm sure. I just checked out v5.18 and built it with the
same CONFIG. trace_printk() on that kernel generates function
names as expected.


> I just checkout v5.19-rc2 and added the below patch. Then I did the
> following:
>=20
> # rmmod bridge
>=20
> # trace-cmd start -p function -l :mod:bridge
>=20
> # insmod bridge
>=20
> # trace-cmd show
> # tracer: function
> #
> # entries-in-buffer/entries-written: 23/23   #P:8
> #
> #                                _-----=3D> irqs-off/BH-disabled
> #                               / _----=3D> need-resched
> #                              | / _---=3D> hardirq/softirq
> #                              || / _--=3D> preempt-depth
> #                              ||| / _-=3D> migrate-disable
> #                              |||| /     delay
> #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> #              | |         |   |||||     |         |
>        modprobe-2155    [005] ...1.  4732.051406: br_init <-do_one_initca=
ll
>        modprobe-2155    [005] .....  4732.051408: br_init: here in bridge
>        modprobe-2155    [005] ...1.  4732.051408: br_fdb_init <-br_init
>        modprobe-2155    [005] ...1.  4732.051418: br_device_event <-call_=
netdevice_register_net_notifiers
>        modprobe-2155    [005] .....  4732.051418: br_device_event: this i=
s an event
>        modprobe-2155    [005] ...1.  4732.051418: br_device_event <-call_=
netdevice_register_net_notifiers
>        modprobe-2155    [005] .....  4732.051418: br_device_event: this i=
s an event
>        modprobe-2155    [005] ...1.  4732.051418: br_device_event <-call_=
netdevice_register_net_notifiers
>        modprobe-2155    [005] .....  4732.051419: br_device_event: this i=
s an event
>        modprobe-2155    [005] ...1.  4732.051419: br_device_event <-call_=
netdevice_register_net_notifiers
>        modprobe-2155    [005] .....  4732.051419: br_device_event: this i=
s an event
>        modprobe-2155    [005] ...1.  4732.051419: br_device_event <-call_=
netdevice_register_net_notifiers
>        modprobe-2155    [005] .....  4732.051419: br_device_event: this i=
s an event
>        modprobe-2155    [005] ...1.  4732.051419: br_device_event <-call_=
netdevice_register_net_notifiers
>        modprobe-2155    [005] .....  4732.051420: br_device_event: this i=
s an event
>        modprobe-2155    [005] ...1.  4732.051420: br_device_event <-call_=
netdevice_register_net_notifiers
>        modprobe-2155    [005] .....  4732.051420: br_device_event: this i=
s an event
>        modprobe-2155    [005] ...1.  4732.051420: br_device_event <-call_=
netdevice_register_net_notifiers
>        modprobe-2155    [005] .....  4732.051420: br_device_event: this i=
s an event
>        modprobe-2155    [005] ...1.  4732.051420: br_device_event <-call_=
netdevice_register_net_notifiers
>        modprobe-2155    [005] .....  4732.051420: br_device_event: this i=
s an event
>        modprobe-2155    [005] ...1.  4732.051421: br_netlink_init <-br_in=
it
>        modprobe-2155    [005] ...1.  4732.051421: br_mdb_init <-br_netlin=
k_init
>=20
> # rmmod bridge
>=20
> # trace-cmd show
> # tracer: function
> #
> # entries-in-buffer/entries-written: 56/56   #P:8
> #
> #                                _-----=3D> irqs-off/BH-disabled
> #                               / _----=3D> need-resched
> #                              | / _---=3D> hardirq/softirq
> #                              || / _--=3D> preempt-depth
> #                              ||| / _-=3D> migrate-disable
> #                              |||| /     delay
> #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> #              | |         |   |||||     |         |
>        modprobe-2155    [005] ...1.  4732.051406: 0xffffffffc0cc7000 <-do=
_one_initcall
>        modprobe-2155    [005] .....  4732.051408: 0xffffffffc0cc702b: her=
e in bridge
>        modprobe-2155    [005] ...1.  4732.051408: 0xffffffffc0cc7101 <-0x=
ffffffffc0cc7043
>        modprobe-2155    [005] ...1.  4732.051418: 0xffffffffc0d81340 <-ca=
ll_netdevice_register_net_notifiers
>        modprobe-2155    [005] .....  4732.051418: 0xffffffffc0d81345: thi=
s is an event
>        modprobe-2155    [005] ...1.  4732.051418: 0xffffffffc0d81340 <-ca=
ll_netdevice_register_net_notifiers
>        modprobe-2155    [005] .....  4732.051418: 0xffffffffc0d81345: thi=
s is an event
>        modprobe-2155    [005] ...1.  4732.051418: 0xffffffffc0d81340 <-ca=
ll_netdevice_register_net_notifiers
>        modprobe-2155    [005] .....  4732.051419: 0xffffffffc0d81345: thi=
s is an event
>        modprobe-2155    [005] ...1.  4732.051419: 0xffffffffc0d81340 <-ca=
ll_netdevice_register_net_notifiers
>        modprobe-2155    [005] .....  4732.051419: 0xffffffffc0d81345: thi=
s is an event
>        modprobe-2155    [005] ...1.  4732.051419: 0xffffffffc0d81340 <-ca=
ll_netdevice_register_net_notifiers
>        modprobe-2155    [005] .....  4732.051419: 0xffffffffc0d81345: thi=
s is an event
>        modprobe-2155    [005] ...1.  4732.051419: 0xffffffffc0d81340 <-ca=
ll_netdevice_register_net_notifiers
>        modprobe-2155    [005] .....  4732.051420: 0xffffffffc0d81345: thi=
s is an event
>        modprobe-2155    [005] ...1.  4732.051420: 0xffffffffc0d81340 <-ca=
ll_netdevice_register_net_notifiers
>        modprobe-2155    [005] .....  4732.051420: 0xffffffffc0d81345: thi=
s is an event
>        modprobe-2155    [005] ...1.  4732.051420: 0xffffffffc0d81340 <-ca=
ll_netdevice_register_net_notifiers
>        modprobe-2155    [005] .....  4732.051420: 0xffffffffc0d81345: thi=
s is an event
>        modprobe-2155    [005] ...1.  4732.051420: 0xffffffffc0d81340 <-ca=
ll_netdevice_register_net_notifiers
>        modprobe-2155    [005] .....  4732.051420: 0xffffffffc0d81345: thi=
s is an event
>        modprobe-2155    [005] ...1.  4732.051421: 0xffffffffc0cc7132 <-0x=
ffffffffc0cc70a3
>        modprobe-2155    [005] ...1.  4732.051421: 0xffffffffc0da1500 <-0x=
ffffffffc0cc713e
>   kworker/u16:2-2023    [004] ...1.  4737.946576: 0xffffffffc0d81340 <-ra=
w_notifier_call_chain
>   kworker/u16:2-2023    [004] .....  4737.946578: 0xffffffffc0d81345: thi=
s is an event
>   kworker/u16:2-2023    [004] ...1.  4737.946634: 0xffffffffc0d8e1a0 <-if=
_nlmsg_size
>   kworker/u16:2-2023    [004] ...1.  4737.946735: 0xffffffffc0d81340 <-ra=
w_notifier_call_chain
>   kworker/u16:2-2023    [004] .....  4737.946735: 0xffffffffc0d81345: thi=
s is an event
>   kworker/u16:2-2023    [004] ...1.  4737.946833: 0xffffffffc0d81340 <-ra=
w_notifier_call_chain
>   kworker/u16:2-2023    [004] .....  4737.946833: 0xffffffffc0d81345: thi=
s is an event
>   kworker/u16:2-2023    [004] ...1.  4737.946834: 0xffffffffc0d8e1a0 <-if=
_nlmsg_size
>   kworker/u16:2-2023    [004] ...1.  4737.957648: 0xffffffffc0d81190 <-cl=
eanup_net
>           rmmod-2206    [000] ...1.  5739.459376: 0xffffffffc0d8f880 <-0x=
ffffffffc0da3d1d
>           rmmod-2206    [000] ...1.  5739.459378: 0xffffffffc0da1570 <-0x=
ffffffffc0d8f88a
>           rmmod-2206    [000] ...1.  5739.471367: 0xffffffffc0d81340 <-ca=
ll_netdevice_unregister_notifiers
>           rmmod-2206    [000] .....  5739.471368: 0xffffffffc0d81345: thi=
s is an event
>           rmmod-2206    [000] ...1.  5739.471369: 0xffffffffc0d81340 <-ca=
ll_netdevice_unregister_notifiers
>           rmmod-2206    [000] .....  5739.471369: 0xffffffffc0d81345: thi=
s is an event
>           rmmod-2206    [000] ...1.  5739.471369: 0xffffffffc0d81340 <-ca=
ll_netdevice_unregister_notifiers
>           rmmod-2206    [000] .....  5739.471369: 0xffffffffc0d81345: thi=
s is an event
>           rmmod-2206    [000] ...1.  5739.471370: 0xffffffffc0d81340 <-ca=
ll_netdevice_unregister_notifiers
>           rmmod-2206    [000] .....  5739.471370: 0xffffffffc0d81345: thi=
s is an event
>           rmmod-2206    [000] ...1.  5739.471370: 0xffffffffc0d81340 <-ca=
ll_netdevice_unregister_notifiers
>           rmmod-2206    [000] .....  5739.471370: 0xffffffffc0d81345: thi=
s is an event
>           rmmod-2206    [000] ...1.  5739.471370: 0xffffffffc0d81340 <-ca=
ll_netdevice_unregister_notifiers
>           rmmod-2206    [000] .....  5739.471370: 0xffffffffc0d81345: thi=
s is an event
>           rmmod-2206    [000] ...1.  5739.471371: 0xffffffffc0d81340 <-ca=
ll_netdevice_unregister_notifiers
>           rmmod-2206    [000] .....  5739.471371: 0xffffffffc0d81345: thi=
s is an event
>           rmmod-2206    [000] ...1.  5739.471371: 0xffffffffc0d81340 <-ca=
ll_netdevice_unregister_notifiers
>           rmmod-2206    [000] .....  5739.471371: 0xffffffffc0d81345: thi=
s is an event
>           rmmod-2206    [000] ...1.  5739.471371: 0xffffffffc0d81340 <-ca=
ll_netdevice_unregister_notifiers
>           rmmod-2206    [000] .....  5739.471372: 0xffffffffc0d81345: thi=
s is an event
>           rmmod-2206    [000] ...1.  5739.471372: 0xffffffffc0d81340 <-ca=
ll_netdevice_unregister_notifiers
>           rmmod-2206    [000] .....  5739.471372: 0xffffffffc0d81345: thi=
s is an event
>           rmmod-2206    [000] ...1.  5739.477366: 0xffffffffc0d81190 <-un=
register_pernet_operations
>           rmmod-2206    [000] ...1.  5739.477375: 0xffffffffc0d84910 <-__=
do_sys_delete_module.constprop.0
>=20
> Before removing the module, the names were all present. Then after I
> removed the module, they did not exist.
>=20
> Other than that, I cannot reproduce the issue.
>=20
> -- Steve
>=20
>=20
> diff --git a/net/bridge/br.c b/net/bridge/br.c
> index 96e91d69a9a8..4067760d3763 100644
> --- a/net/bridge/br.c
> +++ b/net/bridge/br.c
> @@ -36,6 +36,7 @@ static int br_device_event(struct notifier_block *unuse=
d, unsigned long event, v
> 	bool changed_addr;
> 	int err;
>=20
> +	trace_printk("this is an event\n");
> 	if (netif_is_bridge_master(dev)) {
> 		err =3D br_vlan_bridge_event(dev, event, ptr);
> 		if (err)
> @@ -385,6 +386,7 @@ static int __init br_init(void)
> 		return err;
> 	}
>=20
> +	trace_printk("here in bridge\n");
> 	err =3D br_fdb_init();
> 	if (err)
> 		goto err_out;

--
Chuck Lever



