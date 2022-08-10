Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063F558EFFA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 18:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbiHJQCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 12:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbiHJQCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 12:02:49 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C076582C
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 09:02:47 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27AFtM4A010749;
        Wed, 10 Aug 2022 16:02:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2022-7-12;
 bh=GdZTX0Uz4/rrlT7sm5FJs1fYNKDrRLKEupt7ssC7uSw=;
 b=FCwtPKbM+CvVrw5DnjWUDUw7r6HYkjFZz5qn0KZaFgROuaoH//RE39ZTNKMpBK9uCV01
 IYRtqqvQbZIAiJ8I4TWiFKENav11hczD/gHSp8zcGhj6FGW8eMHvBBWVYUMN0ADaX3eM
 8pm7WbfGRecfsrymQK27T+QUZopWiqgBQALc2eSX3L8gV3cthdvE3+37esZisdbC8hU4
 aqPnIW91rooqD13ytE4BgR2h9vpi1EDeK7sFUJ8hGia/hhsgibEAw/ifJtQ7dJrb7pfR
 7F2KjssaiBWkjbzkAg1gvkMmh+XVfgqj8iU3Dd64ar03YtNX0NrMzza74hkKAMNIvQZk ew== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3huwqbjdun-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Aug 2022 16:02:27 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27AF68lJ036859;
        Wed, 10 Aug 2022 16:02:27 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3huwqhsbym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Aug 2022 16:02:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GpyA3XU3Qt/nh4d0drimtsQqnOjGAIrSQ8WsR1Uwo9Ie7DEZpwplY52T2RHc7OX4Fk7BYpWRSRtlDTtn/bJ61zTJlBgurwtUwyf0ojiFrvDTzt+M9m2B+SU9i28ErvbPWb+Yk+7atZIbvTtisG9GFEq2C0AbNQN5yqELDGqqID0q4I29HqbtL93vly5N+uevEPcXAm5nVC98joTYIBfU9gAh8e7frX2r7NsWk5P+7NsQG3Noe6eZk9053W0qh83KCAJq+hb0T1Ve4nwQc3Yhw+p3lBgZX4U2oek6mSryU9BSuxy0a3kptDQp9bi5ZfGLzMi4wcymDAkq1d9oPMeCrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GdZTX0Uz4/rrlT7sm5FJs1fYNKDrRLKEupt7ssC7uSw=;
 b=JCMfV1OFu5HeAnU3m7bDNN/qA7/XJKAO62h17PudutENLMLVOzgCoE+1hqn8uYICAiUCT2psTkdn+7EHXsMNckIC0hTbT/g3KakU3mOvVabR060qZIKgH9xX9Mqksl9+8R0jZBtVyn77dngozvHbdmVvJnheRYbq5CG72GlfAMndvfe3Jtf0oIY3cG8Uj3uAFML5vxwGiivUubQ1whGcz96wOyg15IwfBd9E8OMoq7Z96t/VBdxHiTaLNMHt/WFiYmixqBDI2u/2Qrjg5ISwPG+9sV6pKEbZJJcTisaOlWaNFCaB7xqQ4mCdgcO+FAQfHFtExdz0aU9GL3oYIev5cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GdZTX0Uz4/rrlT7sm5FJs1fYNKDrRLKEupt7ssC7uSw=;
 b=bB6j8lKfgVvpDuL8qdF3Fum+cyt/K5PoX68zPz6xhGyOldhSamR8vxwBAEGx4PDk2o/29Dk4vOmcZx0vNF2gDYkhpY4dCrNJ/u91gEf/MI8d/Ro6tByU/0/fD6Elgb9PQw17RKf4AGzc3lJeNvzQ6RWIWORj1/lM3kv4fZKregg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BN6PR10MB1508.namprd10.prod.outlook.com (2603:10b6:404:45::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Wed, 10 Aug
 2022 16:02:25 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5525.011; Wed, 10 Aug 2022
 16:02:25 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+a7b60a176ec13cafb793@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ondrej Mosnacek <omosnace@redhat.com>
CC:     "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        Minchan Kim <minchan@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hridya Valsaraju <hridya@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Todd Kjos <tkjos@android.com>,
        Matthew Wilcox <willy@infradead.org>,
        =?iso-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>,
        Carlos Llamas <cmllamas@google.com>
Subject: [PATCH v2] binder_alloc: Add missing mmap_lock calls when using the
 VMA
Thread-Topic: [PATCH v2] binder_alloc: Add missing mmap_lock calls when using
 the VMA
Thread-Index: AQHYrNKVCLC25ewGJ0OL7f+tDpGiUg==
Date:   Wed, 10 Aug 2022 16:02:25 +0000
Message-ID: <20220810160209.1630707-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c1a464da-ad0b-48ae-b4ed-08da7ae9b79b
x-ms-traffictypediagnostic: BN6PR10MB1508:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y+Kz/g+b4EzidfGr3Tz9RKCPj3/Mn5dcUGs42FdtoR2MrZZvIzE4jvMCdkil14Thld6S9+qI3rHNZxwQP0knGpGdHKWj3+m3gc5za86+h/Xyd1xGm4yyAiwOBlIVOb5Y98zBayRsI9mvTjU+t66ojkA3VohGE2nGHN3Fur9+Di3Ztz2hbblHmGZnIdMwnfhSLH5GLsylq1KQfD4yu+FtbWposKV8q5Y9DVlM2/KpY+Z6rnk82h67l0nr5nHSlnNU4zSSLDEurBvR/CtS2bOPeJWWtQve3Y3EE+VrFE+z3DDNiNYn+I+wvyEO7CKGXb8lBqygFmLvXOibiQbcLo+zCN+C/hamxDhdx287nQ7mt9aUewoi6/8Duger4Ticf/yN6jejcC5CJGJbDGN2nzbFg0uEZAF/O0KNjl9uvr2w0sP4dagRTbz7MrGkncnmVq8H2ndtN0frUXFacEW/B7UmhKWm+UmbAvNxdF0Fl/JSlBxjEln7DF6hfKOr+dc78Et1iiKlzUQAoKZU+ipNKIYiAuYkX6a6XhcfhY5mB2ueco7kxgWoRGleLSLAtgwajp8e+6Me4KAnDttykjL713K6xd4A4Gjymo9nKASAlkpAwSdLWPIVzG8UQLZPdd8Qq1ZR2Q3d88m95y0SaWtxO9pHgEL2qKg/omwAOmuu0dirxKoVpKvAVJUzE5Z29r0zxbdxhQGUYXdZ/oNxecd8VMVZeJ7FYXpqgwxspG+Dx89W+9liAzVrWsYpgr8QhgtnGPb/yollXOuWPiAefn/O0G56GEOwT9+A4KoDwjag3gbhwl4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(396003)(346002)(366004)(376002)(76116006)(38070700005)(122000001)(86362001)(38100700002)(64756008)(71200400001)(91956017)(8676002)(66946007)(66556008)(4326008)(66446008)(66476007)(8936002)(478600001)(54906003)(6486002)(110136005)(2616005)(316002)(1076003)(186003)(41300700001)(83380400001)(7416002)(44832011)(26005)(2906002)(6512007)(6506007)(36756003)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?tZKDOUfN9TeqjAIBH7yz+xEpBUvZ5G5N56/CKCtkyqj/pjew+aaLWaLEZz?=
 =?iso-8859-1?Q?g5t1sd2H9VGjx+JLV1rdNbVijDJt+HB23zoChYDHH+huyBomoDff4v/PUp?=
 =?iso-8859-1?Q?CsTd/3gN+xfGQw2hfFimueO9hYD9PYoGoTQzTItm1ay/1OqrSlUtYDhI8B?=
 =?iso-8859-1?Q?CKWhIZKYuHLQPO+zl6ADhGLrZSOhG531KNp0bGims1nQCwbTc/BLiYJSb6?=
 =?iso-8859-1?Q?T5bA+PZGT6m1JTBixOxYmLvEF7BJfuYtTml/rnCpw9mSA/oWB+F0/BDw2S?=
 =?iso-8859-1?Q?bZk85RXsVuM/83ThycSneRlAuj4geRdrXMzKLDytS+14sGhmu/eD0Ut0iW?=
 =?iso-8859-1?Q?2K0Eayla+7LMkAzlYnfz8bKfsjRdooZCQOlxTq4R1pXjBfpcVJx2byMFJt?=
 =?iso-8859-1?Q?ieen79oQISrMkdIqi6E/4v4CNrR4uAZzjucs4oNe/3GLx5phrYkc3uk8Nj?=
 =?iso-8859-1?Q?8KzDNg0ggvVAbT61urKTZogcWjPS/zp+eewzTt4OpuRqDeQ9ZVi6fas41T?=
 =?iso-8859-1?Q?r8wIj/nlnbIFgUMFGjTY0qiw+gLvWtlhC2xee7jdN22qbBuRrXF/+Ow8v0?=
 =?iso-8859-1?Q?zwQZkEtmlu0cjKCHbf/hJ5RKXhbajUgD6y34mvVgL0Ec4aVJJKnzNgKdVR?=
 =?iso-8859-1?Q?z6GTaxsJU/tuaoqIttXoIxmMBf6tP8xPd2FNFgz6jLPB7mCVoNqLazJWUq?=
 =?iso-8859-1?Q?lFTcxKGgIIahd1+2LLgLvmpngbitiPmaIMDQmYjfCi2skaCmsH7osJqOnv?=
 =?iso-8859-1?Q?FSFzbn7QwEcGm39XqO3z9TaI5XgakZhGxu4cEJRk0e8bCLizUGfbVGSgNL?=
 =?iso-8859-1?Q?iIGunquwdk42S3u/eyx3i3dM9r04znn8xjRGuuhByb4yMqfySTtVJTnxto?=
 =?iso-8859-1?Q?nKDsGLNuVx6HfqXYofLOaCZW0VyVPkcv7u9+YyCL/SJceWzGnsRK34Cx6B?=
 =?iso-8859-1?Q?M01cG/9Yw7baLsrAH+5xLmDYRWoTmVtdvfdPygRSQvpGxoXuczK3sscFFK?=
 =?iso-8859-1?Q?E3TwVpUWZIOsEACklnDpd4c+iDTTkeB0Bn/1j3MTdKtDVPqsFJgU2MNGgw?=
 =?iso-8859-1?Q?RYiu783s3Q/L6kmYhhFrnaFj9buYOW+ozsnKErvy8hDIcb7hb4Bp6k7A5M?=
 =?iso-8859-1?Q?vOIWI7tVutzoG3tcCzkh2CjJ9WgwdN9R0b/nySEnt1WRuqN4l1JGX0K02j?=
 =?iso-8859-1?Q?BQAybG7B/3SuK28OaesnFepSGE/HtU4unBfB+BMImIsVHTLvFiVWvM2FzL?=
 =?iso-8859-1?Q?I6caB5ejWFOA8qwtW6/XNBdVI8sGl0KrRAgcWDkr1AXPH1NkM3jC0G4dgs?=
 =?iso-8859-1?Q?Ku4Mr775EjJHxrgdEOd0RnM38xEHC9KmZEfY25NKUzfNeNyLcguBXfhQHT?=
 =?iso-8859-1?Q?ifjVa46j338HZjfsVILfhQYfxaKVY7AcpNwalXjl2oZrdT/xmCJP+j0DUT?=
 =?iso-8859-1?Q?osaFM9ACtwywWI2+7/rHizaKErUOEwnd7igkBZKq3bIEJKXuFR6gw4yV66?=
 =?iso-8859-1?Q?NkTK5Ujj3ZPo6E8Yh+oqImngAFACijSnr8V8GQjwFGrObY1yaCpkI2fMWn?=
 =?iso-8859-1?Q?uOxeC1iODs15aLsn0/YNOlSOLOBHp6ehNhWQE7YLczYvHvPR6d53XGx1C+?=
 =?iso-8859-1?Q?IAIhJkT+kD+wYGmMKJzjo08QzmQyf+qcr/sz6kKSQ+QbTO0WZ/12E08w?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-8859-1?Q?FVvjkTJU1fch6aNuzwt1PKh0ySRGoVIG5gkaw0SNKg7gA4XYRYbNGsHgco?=
 =?iso-8859-1?Q?ofE8C/Gv4QQ3K/XGZkINBsWcvJyf5xwwZdoFZbE06f/uBLp1W2lTGzJZSg?=
 =?iso-8859-1?Q?7p7fuRxaNrYByaUB0sOtQWKo4HVfld+Ff8mlV9puwWGge5r/B7qaexmWAv?=
 =?iso-8859-1?Q?aVldgBCQ4WYn3Tbgf4LJj8ZpK6I2DVZfA2fb+rLOImzYRe1Do5y8ncmpGS?=
 =?iso-8859-1?Q?gUXg6COAMsKU2hEr1GNbU8JA9cJjJFM7Om/huYML8updWHzRcrSUEP6TgT?=
 =?iso-8859-1?Q?q+Ws8cyiRPGXejj/+iiTrAsFQXufQWDXhWrKbEaaSycVuhT4vbj97/5Fd7?=
 =?iso-8859-1?Q?5zFVkpJJjLnpWD/LfbboKPe/a/Ha19SZOnhePeR7yf7KdKOl5/cFy0KrDd?=
 =?iso-8859-1?Q?iIKR0+7Y3N+olPj39rkOOUvzm64lSSJ+fD83dJya2FyjaPzwnXfty3NtiB?=
 =?iso-8859-1?Q?5p6JJp8ethncpcW+lwd3HPyyoH1FxFnayJ2K0XgRFa4pyoBZCm5BPSAvB9?=
 =?iso-8859-1?Q?VsMeDjYiD6NZ3jyzppe4i1OJyKsQZNbDx/QOlg6waY67Ek1HWht+fsTo3p?=
 =?iso-8859-1?Q?WpwLKIBFWXm98DZDWvO6QuwEbSSjrGja/asGd49ElC5pC/fRJAe/eYSMJe?=
 =?iso-8859-1?Q?IGVodTQl2ThFhczB0TAW7/WrJuLaR1z0OrtozYPm0zii1BE5WnnFv1at0d?=
 =?iso-8859-1?Q?bA1FN4aZlIwuBJXcs4+jCD1PH6Rw0IIBX0nVJLS8C6KtdozjTPq1WCA1GY?=
 =?iso-8859-1?Q?dT6TtrftX4iNAT6TS5ByBy6J2hOFR6PcmfE7QTni9xhCjElr+GfVrFB5Mo?=
 =?iso-8859-1?Q?jbQxOsMZR2soDxKZLtWjl8qf9avTLOVaSKPdUYuzCaNlsB1HNlrln/3Yxz?=
 =?iso-8859-1?Q?8CNW2pDBfbhGh+evkwidV8lDBv+HjyJXt3RxJOADxavYPBkfI/wby/bFgD?=
 =?iso-8859-1?Q?YkrfKgd9ICYpp01QUngHsfmNS4L3D1npX7Y7ZuKSkzktYlk7fqET2R7jIq?=
 =?iso-8859-1?Q?AWXwm8tnQBQ5H2pTtjX5/T0inxyB09GGQMYe+8D+n5T0kYboAg8fXvtjTz?=
 =?iso-8859-1?Q?CXVRMU0l5dMmEVJwihVJaA8GhdlHDSm8v8hggYM1rWgR0jGWVmfqrD31tz?=
 =?iso-8859-1?Q?ih18SOThO2ZhLteEDPtaxmJgExSY6Rh9SqCbiuJMaEBxmiOAND9qdbq3Eu?=
 =?iso-8859-1?Q?kCAmKWI0DoXpHyycd0SDHKp1mzCBlLpDoBr2PX+bMYfXjZRVsz34I16Njj?=
 =?iso-8859-1?Q?O4SbqEh29YrlWx19VirSSEEP8p1fzBZzWEPCi0fRBEMHbE9ZZ70rqkN17+?=
 =?iso-8859-1?Q?eesaI0Pwf0QncudwSj6ng53gEMRvcqtF5xGSA2v7Ux5E4WBayEXAFaDwQz?=
 =?iso-8859-1?Q?Ytcr1VkXP1hWTc9fwysmO/x7ItmJ82ys36zbvx9JNK7j7tSFCw27Qtg+KH?=
 =?iso-8859-1?Q?16DdWiDed2Rb5KJR8QUIOFvCCu+H/PC7V5EPjmFPwO8K72AUhv403uWPS4?=
 =?iso-8859-1?Q?+uaKllvaAxIyCohsEPVnRneq9f6LwwY75S10z/Ul0lRjIWBzec7ON3Xlh3?=
 =?iso-8859-1?Q?W9IuEEYDwbeKs3K3pqHnnihdjRoPDZ4VIiVF2ryCEw75MU746QxHuLrQkm?=
 =?iso-8859-1?Q?vA6V8rEicuf8ssQVLddpdupK+dfCHpRvX1Ifs+hTbI76eFs9Im9N7kEgw7?=
 =?iso-8859-1?Q?3eh8oizzLYJF6aQ809EjQVvzQQO4b59/xuiswSHDco6JJDbGgEZJoWhnTG?=
 =?iso-8859-1?Q?3WSUy+oa4oexe2XJm8ug+hTyshpcea+qSnzC77ASaJ5xcw?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a464da-ad0b-48ae-b4ed-08da7ae9b79b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2022 16:02:25.2593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L1gf+O6IfThlN9Jhqz5WZ/ItgpL9tirLX/qJj9os/GuJC8c139RT/YV/Azrl1DKvFQcPsR2pdWFPKTyd1LeBGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1508
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-10_10,2022-08-10_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208100050
X-Proofpoint-GUID: ei4W2v3ytovRrlym14_KvpOU5QonOnTE
X-Proofpoint-ORIG-GUID: ei4W2v3ytovRrlym14_KvpOU5QonOnTE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Take the mmap_read_lock() when using the VMA in
binder_alloc_print_pages() and when checking for a VMA in
binder_alloc_new_buf_locked().

It is worth noting binder_alloc_new_buf_locked() drops the VMA read lock
after it verifies a VMA exists, but may be taken again deeper in the
call stack, if necessary.

Reported-by: Ondrej Mosnacek <omosnace@redhat.com>
Reported-by: syzbot+a7b60a176ec13cafb793@syzkaller.appspotmail.com
Fixes: a43cfc87caaf (android: binder: stop saving a pointer to the VMA)
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 drivers/android/binder_alloc.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.=
c
index f555eebceef6..c5e7c6d3a844 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -395,12 +395,15 @@ static struct binder_buffer *binder_alloc_new_buf_loc=
ked(
 	size_t size, data_offsets_size;
 	int ret;
=20
+	mmap_read_lock(alloc->vma_vm_mm);
 	if (!binder_alloc_get_vma(alloc)) {
+		mmap_read_unlock(alloc->vma_vm_mm);
 		binder_alloc_debug(BINDER_DEBUG_USER_ERROR,
 				   "%d: binder_alloc_buf, no vma\n",
 				   alloc->pid);
 		return ERR_PTR(-ESRCH);
 	}
+	mmap_read_unlock(alloc->vma_vm_mm);
=20
 	data_offsets_size =3D ALIGN(data_size, sizeof(void *)) +
 		ALIGN(offsets_size, sizeof(void *));
@@ -922,17 +925,25 @@ void binder_alloc_print_pages(struct seq_file *m,
 	 * Make sure the binder_alloc is fully initialized, otherwise we might
 	 * read inconsistent state.
 	 */
-	if (binder_alloc_get_vma(alloc) !=3D NULL) {
-		for (i =3D 0; i < alloc->buffer_size / PAGE_SIZE; i++) {
-			page =3D &alloc->pages[i];
-			if (!page->page_ptr)
-				free++;
-			else if (list_empty(&page->lru))
-				active++;
-			else
-				lru++;
-		}
+
+	mmap_read_lock(alloc->vma_vm_mm);
+	if (binder_alloc_get_vma(alloc) =3D=3D NULL) {
+		mmap_read_unlock(alloc->vma_vm_mm);
+		goto uninitialized;
 	}
+
+	mmap_read_unlock(alloc->vma_vm_mm);
+	for (i =3D 0; i < alloc->buffer_size / PAGE_SIZE; i++) {
+		page =3D &alloc->pages[i];
+		if (!page->page_ptr)
+			free++;
+		else if (list_empty(&page->lru))
+			active++;
+		else
+			lru++;
+	}
+
+uninitialized:
 	mutex_unlock(&alloc->mutex);
 	seq_printf(m, "  pages: %d:%d:%d\n", active, lru, free);
 	seq_printf(m, "  pages high watermark: %zu\n", alloc->pages_high);
--=20
2.35.1
