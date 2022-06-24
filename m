Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C955455A0C4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbiFXSXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 14:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiFXSXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 14:23:47 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A23C532F1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 11:23:46 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25OHdlgC025292;
        Fri, 24 Jun 2022 18:23:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=LDyfe7T1dOpr4aiwk76GTKDNtTUr6RsH1ErAEMXsahk=;
 b=HuqVolOXvwItu3oYJLlta/ucpI2JjuPxwhgeVKzeeKKo1o77pl5DMC1u3dbjIbxU/d4q
 NjSWYOc+WTz2I5gNJTspcmEE/SEGcg6xauayDb9LwwFIzB/8yH2wqv33V6wAQ5qGL9Sg
 ktHnbjzWQyuFPTveETvuoJegPmF6kAKtTihtneQaJ7vMsy3XcK92Iq/oeMcxgkP9Scre
 d4vOx3IBFWwMXPXeiBmAUQMiIISJNN8IOedp7KCi0k5h6Rfcv6OGvG+YimbGYD9F83mz
 PSPepOZ4Pal6pMpFQGsK73yzY0dTCR1p0TI7O9by9z+1lidjMvKyMQQ0UgaNcKkk5+j+ cQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs78u6gs7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jun 2022 18:23:44 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25OIAqwa040444;
        Fri, 24 Jun 2022 18:23:43 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2045.outbound.protection.outlook.com [104.47.74.45])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gtg5xmrxh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jun 2022 18:23:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j664orwGp6q2dWZ8DOj4Ez1oUMBPuG4MMfrFUZxuvdDvKG/kd/cvbfa03hpM4a8H/39K0HMZPZYsRO9JGqwPW9gtfDtEKOTCnfipME0UTH0hRoeu3n/H0EgBC8yX3QwSkY7mLu4u1leS1kHlifyL/D2iUcIM7XfvKcM7/iuIbtPCoOj0zuGz95g1LUcp95DEVqAc+sREFXk/vwr3vxU+odJC+Kc4vGM9aSU0Xw201fMlpaj+4sg3zPc/cB3uv+Bql9MWjoOvlDG69ZWJf3fwO4M2yYiEZ+26cpu4F1FJtjsl58KwaIqIZVmkgUv6yQmdxBo4xleVWKgoM5NwgvDDGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LDyfe7T1dOpr4aiwk76GTKDNtTUr6RsH1ErAEMXsahk=;
 b=ZhEfLcpSIBGNaPaunqNzvSYX3I4ZThUTG7RC6QO/pLm+GozdbqFaJDU8c/lEdPydc8Lph5VzcvpBZXWAPsnN9Eypkq4j5CkoSaGlyQNVROgpcUEVqvh8CNQb346MoAZI0IqSXwLmStupolT3Pxu0cAPHf8J/7U1nFwWi6X+5gB5b2fQ4n9XRXPCWdFlC6z8ZKq9OLMnFRVWW9GPxwbEX+7ES2N5/R6o+beQxzqQcjaMTdc4PSM1aWkazzpYBxNgZJgqA02XKMTqhqYDqzu3uyRYVv2yCoLuQ3W80Qat+ymRH8/pFoUQJjkpURx+0ciabbB52F9f6MmVS3g7sUmrxDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDyfe7T1dOpr4aiwk76GTKDNtTUr6RsH1ErAEMXsahk=;
 b=Te0+cl1WFS0zGmX3F4MfYK3BXOmgF26FAji0uyb4FVB+ZJbOzBCv0iIZxaDzvTLHIB4xipReSznfYCiengOLKtRsmdEpVpxBtEKm5jiBHy1tKFKVvJykJx2yxRCO0KlGgGXMcX5WRHfQtz2BQkN/Ohd45kVB9U//jFcJid+/2hA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BYAPR10MB2869.namprd10.prod.outlook.com (2603:10b6:a03:85::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Fri, 24 Jun
 2022 18:23:36 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703%5]) with mapi id 15.20.5373.017; Fri, 24 Jun 2022
 18:23:36 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: possible trace_printk() bug in v5.19-rc1
Thread-Topic: possible trace_printk() bug in v5.19-rc1
Thread-Index: AQHYgZTiaV2APa8LiECz6bYrBgXq161SKdYAgAAAwoCAAdkwgIAAXpIAgAMb4QCAB22jgA==
Date:   Fri, 24 Jun 2022 18:23:36 +0000
Message-ID: <9040E67D-323B-49F1-97A0-E7ECC1123B22@oracle.com>
References: <F6C267B0-83EA-4151-A4EC-44482AC52C59@oracle.com>
 <20220616113400.15335d91@gandalf.local.home>
 <E309A098-DA06-490D-A75C-E6295C2987B9@oracle.com>
 <20220617155019.373adda7@gandalf.local.home>
 <3BAD2CD9-3A34-4140-A28C-0FE798B83C41@oracle.com>
 <355D2478-33D3-4046-8422-E512F42C51BC@oracle.com>
In-Reply-To: <355D2478-33D3-4046-8422-E512F42C51BC@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 16cb0b45-5cb4-40b7-699c-08da560ea789
x-ms-traffictypediagnostic: BYAPR10MB2869:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pwl27MaTwymg+gtthNX4c3nKq28SEFzdEQKEKQWYHPTdV/y61J8A+8pn8SwztRCyfCFSt39OhW1MdnStmJ371L49p6EAm+CSjTKyPzo2B1PyaW1KlICMUQzWR4vlKz+A5xdN5yfhZyd3ywLj5xVZGfMN3U+93rt9n9YKTjkrRQdnY5fYkpWz33VdSaLYzP+PgTjD2rbaeLGZ0OqDmCRdV3nidxfu6G1oFk/YVt9biG4W2HF7bZISp3OrqhRfSRywJKEOsj5VkBmJ564pfja5w3gflx+IF7QMP+upIX1DxECV9FsknGXZ8qYzWeoVBsrLJKB+zZb1nf4DGrIFlzIz7sC4Ft0uHzvIszOfiFPgGcCSCyoQQsAEBYlqQrHFNGS9gWUYpdwXHf8LmeFy1zE8ak0Rt+0r0yE3g/RiMuSej/VFqVlrd1gvIN32DyvlZFNP8OdTYDBfXe/50I9sCt4l6e7Bh9RAbDEYAlO3nouqbfRXM4c8R0Rz3bgwbKq+kMUR+h+1kzaXWDGGbUpkMfUH5vRGScWvh4t2+HpuEtWNa+mr7rrs3Cuo0SH/tP2IjjUgIm3TGaypV5nxnxTPUFxRSwxmz/MykezIdyXEjkeQ7AgP4mikL0CUBFoc6d2NcbcK9FheSFp13cssllo4VXhsnt8vu/YKYIfi2CZ09V+F7F1LUALDKebiMwD59BNZ2NOL7EGMkJ5ftKcMvsjelG4OldKfxZBAlBZ3m2mv9TPHKMwOcXi0uLxJBEMOJzuxyue3EzcIZKUz/MQc97zbhsX7Qc7XWmKf9GY3UkNNQswboL1mheOTK2u/B2P3Ayzm3DFHpuIQ60E3oeVSko0c8nRrWw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(136003)(376002)(366004)(346002)(66446008)(76116006)(316002)(2906002)(41300700001)(66476007)(122000001)(36756003)(8676002)(33656002)(5660300002)(53546011)(4326008)(2616005)(66556008)(6512007)(64756008)(6486002)(26005)(66946007)(38070700005)(86362001)(91956017)(71200400001)(186003)(6506007)(8936002)(83380400001)(478600001)(6916009)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EcwANu84t2DWuM4TGu21o3xawUTBiCeJIf24402vGVdIKL7uZqEyDHh6xPdt?=
 =?us-ascii?Q?XmB9DnvFv6W+yECl8xwWVkBwTRFd8NwlSh5XiojshedZieED2k30FzbAXKME?=
 =?us-ascii?Q?YNiJsN3Nyr592Vh+g/TGVNLTJtS5K+SQiAfGPQQoWR6ymUKpr40IAeQdg2wn?=
 =?us-ascii?Q?WaJ8fLHkqRylABnDPk0/dduWmeEy27Dd/8riYq7B9h5TITESOgwQSiVmoAgY?=
 =?us-ascii?Q?0snuc26oSj3XsI17pMiz4T7K1gvo179f5wnBZJjmWnQN+8Yt+DCl1zlB0V3l?=
 =?us-ascii?Q?Ob9ZAV3cL+ZTfWXGqwHTZC6me3edpjnkYhWiiXCZktT+vhbkyQSLfxeA20o5?=
 =?us-ascii?Q?NjAF2Xnood9zx8PK8ptclcjCODl8WirdzW6251qXgxF6Tt2/Q+Dgb+JqmZxO?=
 =?us-ascii?Q?Qk/J5z+46qke6CusWlpE7e1cNlXfjEGu2nEWP7YYIUkPVVHhUnnSINhcctrC?=
 =?us-ascii?Q?Q2HXGQIaSFdpuaaTRedde/vPSSxIq2+ljnpMU1MUtF1QTFuQWn+Z/i5nzbD3?=
 =?us-ascii?Q?zKcLotLHDeW8s8puBx0tJTI1HIpTHCIEiS6Vs5rcMB0YEZULsUMd59ED9XdE?=
 =?us-ascii?Q?zQ1NuDa0isW+dzqDvUo1O1swX/3BGzdnHERbVGK1EjsILf5uqWcdw3R2T8LD?=
 =?us-ascii?Q?T7sujSFHmz0uhAMk0wdpHg2cJ6xvpK7/5lO0ij9xmSkikgWnwsQMyPjytzG/?=
 =?us-ascii?Q?h4UoI18Rpqjlj+TtcGuY9wKoD3kNDSF/KRQq5baz84IYZXvEcWQz0w5f1YK1?=
 =?us-ascii?Q?m6rfy2I+K8SWmCsGTQek35wGdvf/7Zv+WITgzjmRe7ryvhLYGYQvWltBzA2y?=
 =?us-ascii?Q?POpWHZRst3N//Wi4AbO8Qk4NRMN3LvWfV0DO8+0hyCnUfoKyefCGya8Y4j1X?=
 =?us-ascii?Q?9LmCC7jOMSiUkXXxWI7TujL03VkzpgZYjgn1w/iq52GWT8JFAyXy8nVeBfrl?=
 =?us-ascii?Q?L7WFg184Sx57UDGY5KluNqgJ1SbKzKCa8J62wfuDHZb/PqS528YWo5karCuc?=
 =?us-ascii?Q?x0wfuaC3nHiI1vNdoi6SkiadGCz8CHeRydI9qsdynph17Ja264z0xTFcZiwR?=
 =?us-ascii?Q?kE2VUDxknZxI3loWg1KXUug++aiS1JG0Zi6kD1XbJz4WkpVJreAvhDDtZVjh?=
 =?us-ascii?Q?8h242GYsrDUond1VsXpn2RZ/fU48+km+5OA9/kHVhjyV33zisB+q96IYSnhn?=
 =?us-ascii?Q?euan9730ibOSyRCDfyKM12H2VOnPB7DAFWap/KBPo/LVOiu+NhfYeD3CAP9s?=
 =?us-ascii?Q?FXoQnIbRZ/iFBGtIP7Qa9tF6ZniO3OhdDAKOjgVyx3+SAhwrqXfXdktFUJP4?=
 =?us-ascii?Q?Trh1RiyhjVzFzXQ6TlymErth3hgTsWUDUr/W9FIoRUrL6ZgeRgbAqab77v1H?=
 =?us-ascii?Q?9pYTi1xcJ9riqDE+edVNdzzB7iE9gkfJPCyVITgRvzVttfykHiZhMGYIdrm3?=
 =?us-ascii?Q?7fQdy9R5A/mSmQtn9ip1CiDbpIUd37Sz+CuSRwA/dcq3d8OyKhchfrdQwgK5?=
 =?us-ascii?Q?ohs9WgW8IfkZ62oJ33k4k/k9Y3vYtBtbE4cyTkOOitEhb8LqC3fOdfaAsiom?=
 =?us-ascii?Q?Z0LgTZViXjjIsPnjUzpeROdLnr1E1HrTdnWt1p5eo7J5wv4uu8x5KNlJ1OdW?=
 =?us-ascii?Q?HQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D6155B6DBFB8AE478DDF604D1F4DBC3D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16cb0b45-5cb4-40b7-699c-08da560ea789
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2022 18:23:36.6522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hx6hGPUgeq6GU5CQjsVk9tYd2es/bWyESH4MpcYnUnWhCWJZaOEfjqg4HQ8HRKshGc5nlJF/KJDhyAgVJ+thdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2869
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-24_08:2022-06-23,2022-06-24 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206240071
X-Proofpoint-GUID: 0UK_ECCze52e11qWEwD9M-Q4k3LUdoOd
X-Proofpoint-ORIG-GUID: 0UK_ECCze52e11qWEwD9M-Q4k3LUdoOd
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 19, 2022, at 8:57 PM, Chuck Lever III <chuck.lever@oracle.com> wro=
te:
>=20
> Hi Steve-
>=20
>> On Jun 17, 2022, at 9:28 PM, Chuck Lever III <chuck.lever@oracle.com> wr=
ote:
>>=20
>>=20
>>=20
>>> On Jun 17, 2022, at 3:50 PM, Steven Rostedt <rostedt@goodmis.org> wrote=
:
>>>=20
>>> On Thu, 16 Jun 2022 15:36:43 +0000
>>> Chuck Lever III <chuck.lever@oracle.com> wrote:
>>>=20
>>>>> Did you remove any modules before displaying the trace?=20
>>>>=20
>>>> I haven't explicitly removed nfsd.ko, and lsmod says it's still there.
>>>> And, trace_printk was working as expected on v5.18.
>>>=20
>>> Are you sure?
>>=20
>> Yes, I'm sure. I just checked out v5.18 and built it with the
>> same CONFIG. trace_printk() on that kernel generates function
>> names as expected.
>=20
> I moved my development work to another system, and bisected. The
> result:
>=20
> 91fb02f31505 ("module: Move kallsyms support into a separate file")

The function_graph plug-in is kinda whack-ola too (v5.19-rc3):

   kworker/u25:2-1372  [000]  3465.543709: funcgraph_entry:                =
   |  ffffffffc0e8c390() {
   kworker/u25:2-1372  [000]  3465.543712: funcgraph_entry:                =
   |    ktime_get_coarse_with_offset() {
   kworker/u25:2-1372  [000]  3465.543714: funcgraph_entry:                =
   |      rcu_read_lock_sched_held() {
   kworker/u25:2-1372  [000]  3465.543716: funcgraph_entry:        1.615 us=
   |        rcu_lockdep_current_cpu_online();
   kworker/u25:2-1372  [000]  3465.543719: funcgraph_exit:         4.857 us=
   |      }
   kworker/u25:2-1372  [000]  3465.543721: funcgraph_entry:                =
   |      rcu_read_lock_sched_held() {
   kworker/u25:2-1372  [000]  3465.543722: funcgraph_entry:        1.263 us=
   |        rcu_lockdep_current_cpu_online();
   kworker/u25:2-1372  [000]  3465.543725: funcgraph_exit:         3.882 us=
   |      }
   kworker/u25:2-1372  [000]  3465.543726: funcgraph_exit:       + 14.095 u=
s  |    }


--
Chuck Lever



