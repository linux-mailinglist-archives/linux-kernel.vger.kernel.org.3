Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629FD55CA55
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238987AbiF0RIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 13:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239149AbiF0RIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 13:08:15 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61AD18B1A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 10:08:12 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25RG9hc2013227;
        Mon, 27 Jun 2022 17:08:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=xtZQqO+xmB7pVxU9wzrvdi79ceYPNJ5IskNZE0vUjEw=;
 b=msLkaGjU3fKRaCq30ZmSP6K87bzuEDpyrH+2T9H/znm1uPXWSaqP1J8qLNel5Tg5OXNg
 IryiPuY/JKBM/OdDLkvRRgkxXHb31dHwS6SwjRUqRVdo/G9fnouUU9HeAilDt/PlzaxQ
 XZiE3fMDamyWKOwFgDX2H/hvNLG6FeNMBk7VH98m0nEJoOm5KqNvVk3JkvMgv/a6f9ZZ
 tkxuKXXx25ten+iScKhvt9VgXU40aZS3QYstj4W8EGU7D8kJAuPWhfGRROdENdSLKdwU
 ZH469i905M2UGP7lqjJM4i3Gy10U1fqAYbRxdZmjFWUzCX+E0sRmvysd74OU8lcllLAZ ew== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwtwu3v06-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jun 2022 17:08:09 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25RGj01J035032;
        Mon, 27 Jun 2022 17:08:05 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gwrt77sva-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jun 2022 17:08:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EGEbKcobhaXkUNHN9CIigL56yTmy2WDiRtJeR2jNpKwISLFlb05tcc5LiRkjywgDekdei1JlQx119VxNTm0s1SUbG3wKhzgX7mLuYmls2lpgSK0Mvc9RYlPXX3n23IDn5SgRaEI2okwRI0Y1JtjxQLTM5w3csYkNY4cKBPtRYcFs992AE55wdb4dqcGVDfDbpsFQA/gMTZnj4PWT+HX82QJI8QS96e4h3OwTGKgEUciM4eO9qvGtoB4S1ZoO3/dJ1xpB20sHtofoI5Yfr7Jj55aHLvkAXZQU0Cke4qIKoytS0vJOA6NK15C9t/VZ/2DPkpK1IsCgrNDKjtxSwRUHpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xtZQqO+xmB7pVxU9wzrvdi79ceYPNJ5IskNZE0vUjEw=;
 b=MNhohaeNwouUq1P2pD2lEc2xF5uBPkbeiBXwcZjybuwWDXe1EYDueWZeLVsgkKpLsyHdTAz1at3gRxg/1c5EFtojbgHYgGigBxWHXgoWVIDDfaxqjXyhG0KU3J/K1QLEx3WLbDcIjvPwJlhpc/GFWmfyqA842ZYD3lqnEiUH8AZ0RJhCWG1LuNf40bjEM2JP5pQQT1QlEhwffI8AlMUUfpnEC8XIy+s7M0rQmlO29NI4HEXa7J7MoABv54zbwFgG5Snk3uisSeLLW6YaiKxj+jrR6PDMIr9M066BEH5emkR0mLBA2+Uqxr5Cb7BEUxSotX13dmSx6/peCpjyFygWeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xtZQqO+xmB7pVxU9wzrvdi79ceYPNJ5IskNZE0vUjEw=;
 b=OnIpiKvgNv1USAGzFp6ANHqjk29v507mAFHF3JgA2qfbeiv9PmfEUew+CBQxKvhjGl8FmRwq7ZuucpLniUKwngSSe/7H/7f3iRk7E6X+vyyOC8hc7Sq4TAJmMDrCsRbcU+PNpkLSUzVMDxo7k98C20AoRIu4igQ2usFbt1QV+vk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB5796.namprd10.prod.outlook.com (2603:10b6:510:da::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Mon, 27 Jun
 2022 17:08:03 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703%5]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 17:08:03 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     John 'Warthog9' Hawley <warthog9@eaglescrag.net>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: possible trace_printk() bug in v5.19-rc1
Thread-Topic: possible trace_printk() bug in v5.19-rc1
Thread-Index: AQHYgZTiaV2APa8LiECz6bYrBgXq161SKdYAgAAAwoCAAdkwgIAAXpIAgAMb4QCAB70xgIABL6QAgAAImQCAAAv4AIAAj14AgAJ+wgA=
Date:   Mon, 27 Jun 2022 17:08:03 +0000
Message-ID: <308F6A3B-1FB9-42CD-8239-12B0FD0F5FDB@oracle.com>
References: <F6C267B0-83EA-4151-A4EC-44482AC52C59@oracle.com>
 <20220616113400.15335d91@gandalf.local.home>
 <E309A098-DA06-490D-A75C-E6295C2987B9@oracle.com>
 <20220617155019.373adda7@gandalf.local.home>
 <3BAD2CD9-3A34-4140-A28C-0FE798B83C41@oracle.com>
 <355D2478-33D3-4046-8422-E512F42C51BC@oracle.com>
 <20220624190819.59df11d3@rorschach.local.home>
 <3EB14A14-767B-4B66-9B28-97DDE7EECFD2@oracle.com>
 <20220625134552.08c1a23a@rorschach.local.home>
 <0bf1d366-348c-0f91-8f0a-fc9cc6228783@kernel.org>
 <12417afa-331b-e0f6-a3b0-19623e38590b@eaglescrag.net>
In-Reply-To: <12417afa-331b-e0f6-a3b0-19623e38590b@eaglescrag.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a6784b65-e9e6-44cb-3ff6-08da585f98aa
x-ms-traffictypediagnostic: PH0PR10MB5796:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qAlRKkNhGkgfYXxnWA29yQmbynVvIXuTne99ewdrGcYaNNGxJzxOBNKSToKGv6YiifIodHCZ6Epjb6inavvw+ZcO2a+Uc1+hS3GzOLUuDEeVI5W2KoStO/g0LjYfn5pnKNbFgdYz9yWAuPEvokrq3omtmQy6+ld401FjPGfElXAD8bc1Ae3FpwChilCs4l+81buuufPrtEHLq758WE9xbRpJyuZQxmk8oA78FAAnWK3qkL0OMO9fvh+oVnjEA2bBaCzvkW+Gt1HCoRQ77Om6IDMR1+HXNb4SwrJI/Q4tucPWWCBahtirFz5Ed0slmPF7MlbZKShzhB8HCUYK0PTNgxHAqByc9HtCVkwnzz30RvvwT5Ifgdoz6y+vUNvtDLTP3b925beUWFvm+mHsEm7YQySkLQWoZ7DvovaTFRlNjIs2WUgw7HwaCZIYtMRyg9lZH7uS12zzYb+Qp8gR3g8s9WoP1w9bbdzZtdYhmvNZ+LDyZqE4m05a2PS5ZTLNFSAd0QDQFnBBhhqKZiKNaemOZ3RWp24O1BD65MWRTETWqY5KoKLjZWGXCmkIqXjyEy9ATLQY8/Ow7HcTZhRi8dDVRzbGvwLCI+XAzjBzVNp4w+dNVV2G+5ClPgv50Y49Tcv/uyFWLakyPTjQfGvFDnuyt469rBPI+Hmk4uxmW3rVRwKFhklrq5zw6339w4zPYcr26LfT7pcS9OiO5q/PP7TTdxwimgsCfzlA4NiS7IFV2tcQRYPMVae0W1ZosRPhuSDconthZv94SY0c5zS9pXIiOA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(136003)(376002)(366004)(346002)(186003)(2616005)(8676002)(6916009)(26005)(91956017)(53546011)(54906003)(41300700001)(6506007)(83380400001)(66946007)(6512007)(38070700005)(4326008)(5660300002)(316002)(38100700002)(66476007)(36756003)(33656002)(86362001)(2906002)(966005)(478600001)(8936002)(71200400001)(6486002)(76116006)(66446008)(64756008)(122000001)(66556008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zzBAafu5tSF3NCxjlZygNNfN8PjzKp1KKTZ7SHuayFDzju9bo8c7VRIKQe4M?=
 =?us-ascii?Q?ONCdefcoP3Rsm+A6guwtxthmOOOuSYoObA+26nOEgWC+/lZuPONirJXJsUbu?=
 =?us-ascii?Q?/tX+x9J+eGaSAUUps6FoNNJOlb+24J6i+QAKl7DgvXCLvau+KlqUiD/kC/fV?=
 =?us-ascii?Q?RBMl31bl8wVmhJE17IbfDhaOmbSFU6myfpe6PCRka7F0zW5H8mqJzEpZYBKJ?=
 =?us-ascii?Q?bRYpg+kofUNv84OyPAAsnQDZuqhC7ROaXm07cxb5ynGgNlt8TpjwS8Og3wFo?=
 =?us-ascii?Q?Cu/PV9kxjbNRpmUbTHn5J++CTmWq3w0GMJE/IEJtH7Tgjlj+Il5EecOjTtZa?=
 =?us-ascii?Q?fz/xr4/9VWf9HsIrmEmwJ9O7ynkL105x1F2mz0OuX+h8+zwJn3oScf41Ic16?=
 =?us-ascii?Q?eHXy7AS3vgVJuWQeP31NY580sH8YHZ/D6VGZNCVUjIMzH/2aZeX+nXsQ9SwT?=
 =?us-ascii?Q?tqaqoOqJSTvGIKy7UhsECUYZh7aX95hPFZvrhy0aqAjPqoz8lcHiSeQDV3Sl?=
 =?us-ascii?Q?+SEebipXGz/lgkTxiXWbNvf2M/2e0caIlJgeqje7NRH+r3W5hblpGXZ6udS/?=
 =?us-ascii?Q?vrXpUYjKTnPydsVOiu6ywtiDWlB8G8iIQS41GLtFMcCRviB6p1DeFUkXTZ+x?=
 =?us-ascii?Q?yUl5rnJgT2Kyfeaxn3YnxJkuVzGN4p2kL2I0CMHIIcnBAKAPhMvrvJyDM2hR?=
 =?us-ascii?Q?302W6VtxBEzCSUXuwcduhZHubQvyUaGBt835z/9du+CCyybmZ1GWPkS7fGAe?=
 =?us-ascii?Q?5i5R1Rjipa8T5C4mpyabkkaa6yNUNPTnV+yv0NyaR9zchwFFDlELEC/xskJc?=
 =?us-ascii?Q?k4Or+seNZRUcEjsxLrlgb+d3q9itqL32Va1c7QTV9v/P58xdoP+B0OTIhrrk?=
 =?us-ascii?Q?hEeNrzOF2Pmg5/wcUKHYCy588xgcfJUZrdR/iQezv2W7UWjwFsecNAO/Hc64?=
 =?us-ascii?Q?bL1J01b+SrtOI0JTAl1w3+K681vB9ZKbHPXI0vYj5cdxr6h9kauR8ZSz1qgY?=
 =?us-ascii?Q?L4LoYMsV1MS73hlN59oY8J8sioYxGPsIk/QaXkHURg0yd5aOHIUwUSUfz1eW?=
 =?us-ascii?Q?P2alH8VXRuc4oTe8KDtZMZTAHY1DTpd0aICIwm0vBorgU8cPKz3wHtaHiWkD?=
 =?us-ascii?Q?f6Htqm28KDRoF8zf5VDS8KHsn485H2tTAkMsszQS81TfzRG/giBok9eM+VpS?=
 =?us-ascii?Q?EswbCXubT/vw+FEPdECwBQnMrptY+DUJpLwcFQYD7KYKJkw9UYAeEFtfR9yf?=
 =?us-ascii?Q?Qw2h3PlYrL61FQsJYeg9QjZTCPyq7LrsKGwV2kQ7NR30B9asNz9bBG8ibQgl?=
 =?us-ascii?Q?TZ8Lw1T8Q9XjyxmAdNyfC5wnC4fiuLVKalGnXJvUlrQAqD7h13WxW+OJyw75?=
 =?us-ascii?Q?cK+VJwT6nMA1BbSCEkjcGkPvN1PI5RxT9Vl/R3DSYtCayuvseIEGXvau4wRO?=
 =?us-ascii?Q?1Lr1kHUNRBn1Ga59H1Xqebc8MxSjP7eK5PEFofbKWMpi2KhtrNpis88TGGvA?=
 =?us-ascii?Q?GMlRes7iLyRyAgU00CGWw+XHfKprvIOhxXK8s6GXeAfRapirjZBND7vbu3Fp?=
 =?us-ascii?Q?v3Cnt063UFq+oXy8DM33R2Eh69Qa5ZA1rJI+agxsSz0xLTr7o4sh09d+hdJu?=
 =?us-ascii?Q?Pw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6551D86E7885A4489A8EA999C52F24F7@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6784b65-e9e6-44cb-3ff6-08da585f98aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2022 17:08:03.2465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Oll7W7WFq25kPKKGOcgm8YgQ8LYjjB38Z9zof/sC7HURu5G6cXz6OuDKx+vphPvCvXH+sfe/Yg/ICtx+fcnBhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5796
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-27_06:2022-06-24,2022-06-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206270070
X-Proofpoint-ORIG-GUID: DR0KtVYzsTePVdqazvZl7uJYhCRR3ylt
X-Proofpoint-GUID: DR0KtVYzsTePVdqazvZl7uJYhCRR3ylt
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 25, 2022, at 11:01 PM, John 'Warthog9' Hawley <warthog9@eaglescrag=
.net> wrote:
>=20
> On 6/25/22 11:28, John 'Warthog9' Hawley wrote:
>> On 6/25/2022 10:45 AM, Steven Rostedt wrote:
>>> On Sat, 25 Jun 2022 17:15:07 +0000
>>> Chuck Lever III <chuck.lever@oracle.com> wrote:
>>>=20
>>>> [root@manet ~]# cat /etc/redhat-release
>>>> Fedora release 35 (Thirty Five)
>>>> [root@manet ~]# trace-cmd version
>>>>=20
>>>> trace-cmd version 2.9.2 (not-a-git-repo)
>>>=20
>>> Ug, that's very old. Fedora should be shipping 3.1.1 soon.
>>>=20
>>> Right John? ;-)
>> I've got 3.0.2 in there right now (~3mo old) and I've started the builds=
 on the latest tags (REALLY need to automate this!), probably have latest t=
ags built/packaged by tonight.
>> https://copr.fedorainfracloud.org/coprs/warthog9/tracing/
>=20
> As, vaguely, promised this morning trace-cmd, and all libraries needed fo=
r everything but centos-9-stream x86_64 (it's having some fit about not fin=
ding trace_seq_vprintf and trace_seq_printf, which is weird that it finds i=
t on every other build...)
>=20
> https://copr.fedorainfracloud.org/coprs/warthog9/tracing/build/4564577/
>=20
> so dnf copr enable warthog9/tracing and dnf update should snag 3.1.1

Updated from your copr repo. The problem persists.

[root@manet ~]# trace-cmd version

trace-cmd version 3.1.1 (not-a-git-repo)

usage:
  trace-cmd [COMMAND] ...

  commands:
     record - record a trace into a trace.dat file
     set - set a ftrace configuration parameter

  ...

     dump - read out the meta data from a trace file
     convert - convert trace file to different version

[root@manet ~]# ls -l /usr/lib64/libtrace*
lrwxrwxrwx 1 root root     20 Jul 22  2021 /usr/lib64/libtracecmd.so.1 -> l=
ibtracecmd.so.1.0.0
-rwxr-xr-x 1 root root 142032 Jul 22  2021 /usr/lib64/libtracecmd.so.1.0.0
lrwxrwxrwx 1 root root     22 Jun 25 14:28 /usr/lib64/libtraceevent.so.1 ->=
 libtraceevent.so.1.6.1
-rwxr-xr-x 1 root root 153944 Jun 25 14:29 /usr/lib64/libtraceevent.so.1.6.=
1
lrwxrwxrwx 1 root root     19 Jun 25 17:53 /usr/lib64/libtracefs.so.1 -> li=
btracefs.so.1.4.1
-rwxr-xr-x 1 root root 133384 Jun 25 17:53 /usr/lib64/libtracefs.so.1.4.1
[root@manet ~]#


--
Chuck Lever



