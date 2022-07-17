Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6F8577631
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 14:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbiGQMmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 08:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiGQMmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 08:42:43 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF372140C7
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 05:42:42 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26H94DKB023588;
        Sun, 17 Jul 2022 12:42:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=t4TyCXFb6/Dl0fxB0YB0Wi3r+pubEiOSonhaFxQIkxc=;
 b=L3oPDbC/A3945pYNpak7kusG+xdR/sPjRIyWLeLoQMH6m1On6sniCuUyWbLdn0ABdjQr
 XyyepB9rDmAq7jhYxG59+PdJ5yw71drrBmQDkkxsmIJHymHTGUG/LHn3a+U1xDwFVmk/
 8bTlgYJ3Hdtj7AddQwfdpqiUyXl7v80/+/AFjoLI6SDFL4f9CbSu0b9/uihbcSswph/G
 h7WOM1ZMx/3rNeMmioxMADy6cH9Rd8wkggi8PM/VDgjp3JoQinnQR3hspzDQZf1WX0cc
 9ynfy6H+Inn9nlUOd2IJfHl7PgS4VYG6Gj0nnQx4m7o6DHAFoWjnGlGjqB36838CXP2l qQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbmxs1ftn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 12:42:31 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26H9XMFW027392;
        Sun, 17 Jul 2022 12:42:30 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1m9mpvh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 12:42:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UMy6CEXvFmwOYrNSXUvAmhX9mKyVQLcWxU7SlXVv+6a7m9UsVF6u6nH8xvr+f8kbjH3Gtpw7tYJpq44k5QMfYAnuoB98JImDxreJOrYfrmpn7hSquenbtryORYpyegIN1LzjAF4h5Yh7FCpJbZnO9hU7rkD61J4a/BoZt5SBNsRt/tiqHMig75oOwzjuL1Rp4SJhMW7Fp7KE8ZkUFJdf/mqosE7KwOsw3P8wq9VED71KTG9OZOahsHoe9ntP9vSDE6KiZfNue0jrq5niaBDKHShpOPH14XjdOXBFEo1Hx/uC1QpCsjcnn2fyMxtrK7mHiajZf/vkb8tnML1HiMJFAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t4TyCXFb6/Dl0fxB0YB0Wi3r+pubEiOSonhaFxQIkxc=;
 b=T3vXEAVSsBB+RZrgRDgOm2dwhMJip2J1o5nJS0e/VNut0EY2Ecuur8SR5p6tpL5TiwVuk8vltwZI5lO2Jj5jRoO5tdpclGBhWCs1jEz1UfCn4Mts5bjC/nQlqOgEGJcqznpMHWnOwznp2OTqfTE5MW1S605787tRbqeCki4/MDk++w2ip7c9FFuPietRIQ+ggV48JXk5iSVA5WnXjgFhRoSIRORBihG5F+LwX8SypySDLiUptVNXav9NuXd50FWGDQt/w/1eckk0GpakLisOpqZdi3RxXEa5xnzenRF9nK+Bc0pt9SyCJOT+mUsi73FDy1yrNsM9YgZ9nCy0xO3w5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4TyCXFb6/Dl0fxB0YB0Wi3r+pubEiOSonhaFxQIkxc=;
 b=OwmXqGFBQf/PHR3yvLn3Up4V9MQXGL7FkEVut7jXCxwKTe4chIS0FEmU/rIRRw2RoJs8d0+/0mm55bA7SAcbQJF7kxRcdb2C7qyTS7NerDNi7imlqDu2Gqvu6eXT2ZHF/+GsGen+wLOhKLteY84BRmlhedK5jQdI2JTwkZHY1ms=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BYAPR10MB3429.namprd10.prod.outlook.com (2603:10b6:a03:81::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Sun, 17 Jul
 2022 12:42:28 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.023; Sun, 17 Jul 2022
 12:42:28 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Yu Zhao <yuzhao@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v11 00/69] Introducing the Maple Tree
Thread-Topic: [PATCH v11 00/69] Introducing the Maple Tree
Thread-Index: AQHYmYdscyeMwVIPS0CbwXe7JFDqlq2B9iIAgAAa8wCAAHEsgA==
Date:   Sun, 17 Jul 2022 12:42:27 +0000
Message-ID: <20220717124221.qwc4pvx6xsiwgefn@revolver>
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
 <20220716212050.562604df2a48683dfbcc7e57@linux-foundation.org>
 <CAOUHufaxubu3_Ee-G8q3o02fkRoTf6M7-5=85_B_PUtsWbNa8Q@mail.gmail.com>
In-Reply-To: <CAOUHufaxubu3_Ee-G8q3o02fkRoTf6M7-5=85_B_PUtsWbNa8Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 75eb7b7b-f7bf-4537-375c-08da67f1cedf
x-ms-traffictypediagnostic: BYAPR10MB3429:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0JR1EqQFn4vTTqcbCrauALHtaNlEZr6F5fwFOqfAlnu1QIRvOXc0WVKt9sazwZjepf8nL42xk24B1vWQm5L4m7IPLtSEv6gIoF8a12ttt8lWUoTxQthJ2rHdbhqfenV1YYCEZETlffUGgB4A/GqqIMj1bKvXdN1VE8sYgzlAJTj8xmUPstQKEZ8ZVAaoiwodjPtsJI0fMHmV6PRQvlW9bpl/5OenbxRNIKfyOvW5mE97RFVCaWHzjfwbRdFKjjLYFcBV7CWJ4PKvPyjZj+axRkvMNAnbhJcSw2aP4VMI9/b9xwpxJsVktFyqYv7pf6zBOBTzzQj6LkX4/ggiazqRBQeB+8C/Zj3Fr48HKqRuz/C2XFRNI8KkyktwK5hktuCQlCH0BTfSiCbt9NRxytWxhe1scKjjYBynV3X2DOFQKno7upWjhHlUaewMfzkS5ZCVyrvwwEIhYf2mKSkBUlds7dFYhF60bL26q7Jzm9xBtC+rn21yzk+moRO+WTTISB/TGYlQoR4pff65maLMwwvzbGY15xXGWJRVQJdZCxrErjIpiU+F/EZxVQ4IR7hA454eKPPXdJ43rRtAuA5mFVaRCOwbXPQVIKhnubtDLfrI2k/0xVyeNzvVFtfxTU3gZiQtd692BsWSoZuZ3tZXPu0Pm+ZmjE9EryzjswOMmcnXlXpnCrbvYGSEIXIlsYMHYbodUrdlb1rtqmRi4nwx1ErZyBEEnbaFFjXXW3JEJInko0sYpEzOtapOZ8+UOcP+1zR3uNT0glmNl4rXkaZtyti+lH7/5SNzssn38Ug/0Wrbi4HWcmRDLtIjgovcOU3R2ohQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(346002)(376002)(396003)(39860400002)(136003)(6916009)(38100700002)(316002)(122000001)(38070700005)(91956017)(66556008)(76116006)(66946007)(33716001)(54906003)(4326008)(8676002)(64756008)(66446008)(66476007)(71200400001)(44832011)(26005)(2906002)(41300700001)(6512007)(4744005)(9686003)(83380400001)(186003)(6486002)(86362001)(5660300002)(8936002)(1076003)(6506007)(53546011)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UVNZs70+EftVL7Zy9p4l0wJIQpcTCSZJvI3cksDRmBeq8ClAefWp0ZVlWpo8?=
 =?us-ascii?Q?rqFsVFPWIaVc9aLU0G0TQlPNuOfmAJmUw7sAgvdhrSt6e6QA9R6y4LPNcTuW?=
 =?us-ascii?Q?hzhamrXYbCdReopDkWgVoKvhAWlTjOa5itZ3PjqdSqTVwjg87HJaxkzS8aEL?=
 =?us-ascii?Q?nEboQylg4Mfo5WYMEuttib++lDm8d5W6Hk8I5dS/uqu/QfGPYfNM6GHevaHI?=
 =?us-ascii?Q?MJqgVZZkciO7DOISk2EtQcCfRLyYtNZx+wOU7hSsNLE6Y1pT9Zwc3X7RXlyT?=
 =?us-ascii?Q?6zLrxplHkPEBURT1pcCm6lzXEUhzKp5ruFi6CxwtzpqQkYqnlLUjMyoJH6MP?=
 =?us-ascii?Q?B0sJ8/6aHATDEA7GsHFSHftrfvzYDgMylaVOUIHtspZtiT20+SoNKJym9H3w?=
 =?us-ascii?Q?fovjm0P9KZpuR9KLlU09JfTDtViFQ7ytKkbCpyHkgcR8KicVo5C7aFSypF8Q?=
 =?us-ascii?Q?HijmHMRLKAQdjerZAvDPGIFE4OWQA/8bkPY8inxgKxiWOUAad58Fo/Kym45X?=
 =?us-ascii?Q?4vFR6XQzy1N5XeDkpCwzICT+IClsK9RQ4nGi5y69V0W7Txc9TwZdk9xbpIM/?=
 =?us-ascii?Q?P1z1zohMRJQbFZ8XovIzM9R6B+SXbfFEdOxCwTZDxotEZhN3Ks0zq47A/TjL?=
 =?us-ascii?Q?drbQGefNzhBvz5BzSQaKBAULTmfMN5nzq2oMRwkeSO8woaNCWBhMfc1sMlt6?=
 =?us-ascii?Q?H9bLQQhXJUEDx0MWrkwJ/i/cJ6gZGa5XCtj3yioMPA2SFozU3GD7t0sbKPIv?=
 =?us-ascii?Q?28OUV8Qtx3+qYmoG9vYdvhSB34a5JX02ho3BJa0AZhI9YNI3Lsu2boDhN166?=
 =?us-ascii?Q?SY0qCreqAXxPqk/JM8StiCkzxlMAjRh6P+vhazWD01+grTcuBmCfLtYmBcHt?=
 =?us-ascii?Q?fJ2s6VtfxogdUlGSyGmk+SsZAw496l7Y/K7y8O+jFkkESDWD9w70pw2/HTnK?=
 =?us-ascii?Q?PyO43SEwFZYQOxU7tyN26YS/R15wn5Mh92E3PmcPNjz5MYAfZg66UgAa8PnC?=
 =?us-ascii?Q?ADvmdpmEr//l8zUhReeAal8nQWNnFep9A24vLmOhtZNCB63XrR4hIFH1yl5a?=
 =?us-ascii?Q?gfdzPe4FEIrKX89fFwbu6fWdL5EjHwuCZsOzSgUWDCr7CKV6MUjJ+7ItGqPf?=
 =?us-ascii?Q?7onwelZioFB/pZcut7XhydG2/ZPW3d188kEr64cdPwE9KxZ7VVU4ydtuTsu2?=
 =?us-ascii?Q?9Ko6kOS8jauiGBgBLOLLIZAknxyXCwBLuCwMnbNGzSa8BGhXOaKuVFLG+Lgb?=
 =?us-ascii?Q?2aIAxQcTgC0+jTpqQHEYH27A8eZqdkrtgwiqdu2LkCBu2yFXkjAk36B9GlLD?=
 =?us-ascii?Q?bHkRHTKrbHfVnCecvpqtQra0QwYEGlcAQSgxz545/ynh2qOPBdezvXDhffoZ?=
 =?us-ascii?Q?C9Uwat9oga8KWdd5JjXp27nFu9xNxPiTbZUetxoe2N5rnxXF8wu2a5x9v0pL?=
 =?us-ascii?Q?7cbcIQekRBfOkAPZTENYgVywhQ3jPnFTGSHOhjaOnO68dbgIyw/cFK5QpQpE?=
 =?us-ascii?Q?iatFS230AUzXj6NPnKkhV5Zn5wa4UH01EnZPxWTSjy4becPtvyr8ZU7l1FPZ?=
 =?us-ascii?Q?TjyHxN705jdGi1PzV3HHM4vnQh9PdMKmBRC2bJrelCoR5DXHqbO8zoDTwaoj?=
 =?us-ascii?Q?Bw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BD62999133B06D418E62AAC6639360A4@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75eb7b7b-f7bf-4537-375c-08da67f1cedf
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 12:42:28.1392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tCe123ZT2Yc8cRdCyZsiK6IVchSXENuCeHHO+UD4dsag6shRRGRnAOCHV30nGUrp0fooxo32U4dNNKP9yjMxmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3429
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_06,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxlogscore=918 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207170061
X-Proofpoint-GUID: hcK5WjTjgowEMzJRU50B6H6mKdkl28CY
X-Proofpoint-ORIG-GUID: hcK5WjTjgowEMzJRU50B6H6mKdkl28CY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Yu Zhao <yuzhao@google.com> [220717 01:58]:
> On Sat, Jul 16, 2022 at 10:20 PM Andrew Morton
> <akpm@linux-foundation.org> wrote:
> >
> > On Sun, 17 Jul 2022 02:46:32 +0000 Liam Howlett <liam.howlett@oracle.co=
m> wrote:
> ...
> >         gap =3D mas.index;
> >         gap +=3D (info->align_offset - gap) & info->align_mask;
> > -       VM_BUG_ON(gap + info->length > info->high_limit);
> > -       VM_BUG_ON(gap + info->length > mas.last);

What arch did you hit these on?  David asked for me to restore some of
the BUG_ONs in these functions and I guess I got it wrong.

>=20
> These VM_BUG_ONs are new, and I hit the second one quickly:
>=20
>   kernel BUG at mm/mmap.c:1631!
>   RIP: 0010:vm_unmapped_area+0xdb/0x1c0
>   Call Trace:
>    <TASK>
>    arch_get_unmapped_area+0x1ee/0x220
>    arch_get_unmapped_area_topdown+0x25a/0x290
>    get_unmapped_area+0x92/0x100
>    do_mmap+0x13f/0x560
>    vm_mmap_pgoff+0xcd/0x170=
