Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8721158EE6B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 16:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbiHJOdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 10:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232637AbiHJOcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 10:32:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD181C122
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 07:32:51 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27AD09dj008179
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 14:32:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : content-id : content-transfer-encoding
 : mime-version; s=corp-2022-7-12;
 bh=kbXjVYamJBjzs3HcxBzNR2XLoQEvTOAzRMWj3EyOUVM=;
 b=Ix1k6E8FywCEEEifPs2skyivn6bZqZoPLHGdUtW4coj2jUfNpSL6/x1t0FFEmOUe14eq
 F7ydGYmlTxrcvTqfbGHcYvNyXQX9ZDw07MuKjSfl6f2y+8MmqKDa2G8Dcwnb+EXrEEsL
 F7rYotP0Zm1hLFWdU6/bfhW/HO/4xAGeODAs3EeLj1oHyVuU3wYgVwXLEnP5dC2wPXP1
 mZjWYq2Xf9kjO5aG5ILZgWhpSxjgAOrIp4av7732vnFW88qGkY4JbNQPICOK7BOxKttg
 lsrfLXoTobYkJG490L8d/8HyHhjuQ7oF2fHDhrjBMtI0BMMH/FB5lbHydR8KC5Aj6ZR+ kg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3huwqdt25f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 14:32:51 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ACu67v015470
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 14:32:50 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3huwqj6bda-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 14:32:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Em+DiIP16XtIOPqjES/QGZ82I1LLYjMsAbqjXCeWMN69LrgmMXMDZgtfx5yTXpWGdwLUR3cdhpraph3VLa7i85GKVLfMDXoEmeJCHGRXOoFyXw+GtRLumeQYyIUzbexex5227aMsKwDpkH8P/Hly9Z/7XY3JIGEjuwnmi1QK97U+1IYaNwbJDV42lwPHk7Tp9P8r11rNAP/vSI3sf/nIaufAdHwxl9K6I8ZN9JcPp1/2YASFUPZ0o4B2s9GELQJzoc5mOhCHM4oNa9bs/9VCnL3CkyjI18kOgipEy4nwPoc/Vj3ze9SCb0ZIbBoXCVXVrsh5NW01e2nkfXfw/rggQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kbXjVYamJBjzs3HcxBzNR2XLoQEvTOAzRMWj3EyOUVM=;
 b=hyEgwr/ivKg7FzmCNB/bu3hZwUZclWL2hBVF8wmyTH+3wUgJBTthikOJpnk2dGiilxAngVCqxn6KfXZbDojVKLYsBRAAotP1yEZ9QWzbEK182GwNg2fOrl8na09aTqK3ClOVY0pSjjd8AEGf9CJaWJiewh10o84YViGAtoBHgzOUMHCEVBj3Lb8hyMySgOs0nzjloDFBHS6Hcdg7gVLJvIwWZm8UHmhcQEi3pS0EEGlGW2bxPyzKYlif15StunO7yWbmmumicOr98BE1MVPzK/JDFmoJDr0mu4FxR42oIX0lqIJor4zZ44hSOg9rL41dKuphiruGJAwRjGtvT9WYBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbXjVYamJBjzs3HcxBzNR2XLoQEvTOAzRMWj3EyOUVM=;
 b=IGZmpOv/AVvCKo0v4aW6RdWhRx1MhMoesrdsJ+d+qI8WzCegxXlLnuust++7PeGGbJlxepFyiKg8JfaY/aZ6iwdOX1Erk4uBhWKOFrWIlf0PQHnRS9Q66VJzjusom3Z1rpuJStDSMnviXjhu3GtFhnmyz+xtr3MSlXVLtrCAijg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN7PR10MB2753.namprd10.prod.outlook.com (2603:10b6:406:cc::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Wed, 10 Aug
 2022 14:32:47 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::91ca:dc5:909b:4dd9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::91ca:dc5:909b:4dd9%9]) with mapi id 15.20.5525.011; Wed, 10 Aug 2022
 14:32:47 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: C=1 W=1 regression in 6.0?
Thread-Topic: C=1 W=1 regression in 6.0?
Thread-Index: AQHYrMYPE5Z9/lC1FkW3UEEd6n5Cgw==
Date:   Wed, 10 Aug 2022 14:32:47 +0000
Message-ID: <32609325-C7A7-4CB1-B9F1-7AB0B6B51AE1@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 666f54c2-8521-4d0d-b755-08da7add3261
x-ms-traffictypediagnostic: BN7PR10MB2753:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PLKN/uFDUEKcMWOq7wubKcSmsiHcNkwf/iVPnHDi/TCSsHAuMJZDNUZGlFrWRzGJWaejGgFyFnMBXlwU4Y3snfFi7WgtggBzHiif6o2L+3hzfoDmX010zidZVel4SXdOK2vRJL0P/uioQVsyjVrQxuLrOhTi+wSYkxjp85iTm2TZv65HGRhMnGQ9+6cob9hVcMx2Wg16iiemeb8ilY3/uUgchkvOJtDcZHk5eiWwGy99myGvk8yHTzSDO4fpHlSQv9GBUVuiJjQ1rwCxN1A3ixPZGlACKJugoOTfkHLHyn/6Afk/ajGs+O6CnBP+asX4FKsFRYBySnwHGWkWDS0XTk4FTrE+/lPJ0PcmJ1P4aBBJNpq0zo4/Ppq8bhTJwT9n7SQQYPZ34ba3zIY8wqinTxErugskD3tza/tTSS7uHhtnHgnz/04tVyMe2wFbxPcAJvVtnkHcrrbWlSfCjsVr78R5nIqgbGOjHd7izTzHEcusU4Ay8W/QKkL5+0TPXpEeAC0mnrUewkF0v7LXB0OQ9jGhidiGwPuCrrE96W8kXlRaNaBl92hlUlpSjkRRrbmKbZE8QS+X80pxCb16I+j2WdtCrcZ6UKZAe8mvQ0n8Kmc/tsn7zqo0q3Uscf67TieMYCqTuSgdtSafRmt/ny9J0pIy3+fthFm+reeWlNpUuRNOCvqZ/ZKnW/PUJEFWPbs10i2WEiShVqFwf+sGGazUKjekhoM7E5esgKKYCdRKBohr3o1gXwjzmfxjgds5UiUb+oTudziditWkOT5V0a0gRJXyLHKnM1RXOTw72fQfItgpl1T2Ri6GS/P2iatxs8pRwuOKreTNJkCUmE2QGtKNrw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(376002)(366004)(39860400002)(136003)(6486002)(38070700005)(38100700002)(478600001)(66446008)(66556008)(71200400001)(64756008)(66476007)(8676002)(91956017)(66946007)(6916009)(86362001)(316002)(76116006)(122000001)(2906002)(186003)(6506007)(41300700001)(2616005)(6512007)(26005)(83380400001)(30864003)(33656002)(8936002)(5660300002)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ketgoVDpGv8f3gX7c+B8R0CEioi+GYbnpi4EOL0xOIBoaSUwfvK7oVlBapW9?=
 =?us-ascii?Q?Fn57Dnwtt5Ud+1gX53YyDVqo/0MFhzm1cGB4q6ft7jDwsyvHyhg8MukzUUXL?=
 =?us-ascii?Q?wJcHyUn6fKSSK91pAdzhk7+q3TOU2QzxZv0p6RyW7WixnEfb5v/kkksIj0zZ?=
 =?us-ascii?Q?b8SxQwhrq7fRKA9Eqe27FmOyK/ef4Wk2+Cp5MrN4jNCqwCgcswBj9lAQwzBf?=
 =?us-ascii?Q?s7HQxWc8QFl1fhZANwz06OJaalaMj+5EZuHBEFAfQWbUaxwv4HH8JUyeYnFi?=
 =?us-ascii?Q?KSZ0GzBQBWwpAUNER+Q79/lUmcbwjx7goSsLSH+g+emAXS6f+B7Fl90gIc6V?=
 =?us-ascii?Q?kZHSeWu937VqWjbijoOWoafT6EwHKb/U+fOu7RdtFGySqePIliLvRDDrqFD4?=
 =?us-ascii?Q?KOtkMz4LRtYIw7dRpGNLwXpqtvK/9Ewrvz7xvGH2Hi5v9MH0diPD7PUeOvah?=
 =?us-ascii?Q?K3XVUZxVBg/JrBXcgz2z5nYsm+HoUrTJCaeiBwlU8Cg8IE4CVeqhQ6nNO5hn?=
 =?us-ascii?Q?TYOTt7S1HppIQpOieyMKcg9y9/GVCc8eGappsZRO4E9wpTEFDZr5EurqXtE8?=
 =?us-ascii?Q?9xOya+5DyXWw7/SehrzPEvdc0P2wUwbyFEiEAsNSIFMdQjEUa0Ob2svjhldO?=
 =?us-ascii?Q?G7LDnTLAoOOZPWy4awXBXZwjth06biIV5lxAuOqYiLgidK4hbsfWigzXcsFN?=
 =?us-ascii?Q?KuRV//J06FMGqcPb1UoFvCPrDksv7iJNWY2OQKp97h/oNmJ/yrOCtVXwWuUM?=
 =?us-ascii?Q?7/heehlIWv8ze+nDzYvUKbb4XXJjJIXEzfq7J8ddo0F8mVJiZAcJhhcm80wM?=
 =?us-ascii?Q?dAgH6vfR2JJ3QGCuKUa6e2/3t/03EPuEGSkbvV5gIfPfUEiXg7s9kVnZCNXi?=
 =?us-ascii?Q?OYbxvPD7WB7K6dxdxXXh/BLkN1xFqri2147NgNoBX9GnPu1TS5TR/3AvbQMu?=
 =?us-ascii?Q?3U715ZtnZnl2i9XgNn96pmyqz1TTq3Xaa/wmTgd+4e6lTfv/n/C9ulJIB6Ln?=
 =?us-ascii?Q?wE2xhJ40E0/DDUfGfGRLSTdBcFkZLIe80sRgiaGXdjirNhF+f0FtJyLbysNC?=
 =?us-ascii?Q?tt/0/MzwNxGfaTTV5PxpjpoidOWgurf0g38MSMduHjyIAmdzYcZerEyfVOuF?=
 =?us-ascii?Q?I43jqBF3uAqzXmZSmhf4l13u8sFFFfLYS0GCFXHVjI1r3O/BD7z+T9/3pyXd?=
 =?us-ascii?Q?HWGcIbbZFJYSne9SxmBAJgFTmbtxMSj2tS2DG84dWrEzs0grpu5Qo3GfLgD7?=
 =?us-ascii?Q?MuzRWzto1/LezHLjpUuU1X875gHQtKgKwWSCW81mqdJT1mOM8ngRb1gUJOWi?=
 =?us-ascii?Q?pWb4sbIjiq0VQh6ECImE4pueG3TZqNfi36zZhp3A75AYzmaFKTJiWf75htyy?=
 =?us-ascii?Q?qls//h07KXuXB7kYPd+2n5AGF+ejwG6m6TVdKzLYgWjXMxUI/68vyyaQiuBh?=
 =?us-ascii?Q?fcGFM6UaGQlMUNbuSz2T3YuAaaSTwzJEzKx1UMq9SA8HzSy79zbpky7oa1yN?=
 =?us-ascii?Q?sWRDSoxiTLDAFQn8vhN75cBmx1P66KhrJHke01OIy96x2oksic385bRQOVDt?=
 =?us-ascii?Q?Ccdmpvohpg3/62xRffh+w7ZQjj4ulhO/FPUUTGWnGWs5WtaogstkDY4fI6aB?=
 =?us-ascii?Q?Uw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3F94F3B55F489740B3D2BBC55FA5CD8E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /dPjRtAacfuRBj3Rklpv+9KPYFAz5gr4MrBTR2Lo/cWcyuGMmJZEWjTZWCRPHebxtzkp6dP7sNKXgp2jFkfAnwRSmT5JtSPYza2vPbY+z8WaPLG2MCLp0ZVZ6LPW5tkOTUH/YN6QGhqq+PRglngfPVQ+o7BFtSdNnbgt5HqaXOK465KkqfwL4JK4G861CUWhTe/jHz41LiJOpoBGRw5TxmyKAh98+5obw+FWYWjEw7NwiWTsFadwwPkKg2mMzD14ZS+jt2YNWU61kyYPjSsGMEv0krWUV6qoqMVYPYMr/YNlL3HO2Pix8nQu36hloveGP6MV7tkKMysF+ARn1iazoGoYHZwvw7RIRDr+8EgR+8/jxNrKRKSOkx1uI8wo1A/kG4dpGzHNXkBFpg2tolsI1h150Awd6F7LST3TFk1c0DlV93UnGTP9UF6yY9hnBliMDM5bWy48a1VpnYYWTRkO6K0NGOM7v74IC5NQPFnitPSSoSIxwoyj54bLFd3gGBqu88VIdNQdFFfznCdDbYq9IGIqUqEUXpFNiIu0LJpGFCZomydcjz6bfv6yjpz/s2cp8swZYzoV84CB8IPf1rpoP2fLiWbgVvuedmmvcmzN3i8k3t8I+sAGm1LagnAVo1V2LlslSB2yAn85lBeorjGmMoZJzrubNjmGZdc5KmcLTlpf/6jhtLUWVR3p/LuISfXRhnVb/PwBmG5SZPkgVtsTRTkgYvcTw6wqVsEfdIIGitY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 666f54c2-8521-4d0d-b755-08da7add3261
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2022 14:32:47.7503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eb3KYxYMT16jt6cVxZDxEygfHjP6Ql+yP4ZEDEAkZ+tjJs5DkkT31vozYbhOOxqKFPo2p70Zb3vAOrjzGo31xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2753
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-10_08,2022-08-10_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=976 suspectscore=0
 spamscore=0 phishscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208100046
X-Proofpoint-GUID: w41sEmfaxejOno8MDJ8Sgjt4iigPnuiG
X-Proofpoint-ORIG-GUID: w41sEmfaxejOno8MDJ8Sgjt4iigPnuiG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is usually a quiet compile, but after rebasing this morning
on origin/master:


[cel@manet manet]$ make C=3D1 W=3D1 fs/nfsd/vfs.o
make[1]: Entering directory '/usr/obj/manet.1015granger.net'
  GEN     Makefile
  UPD     include/config/kernel.release
  UPD     include/generated/utsrelease.h
  CALL    /home/cel/src/linux/manet/scripts/checksyscalls.sh
  CALL    /home/cel/src/linux/manet/scripts/atomic/check-atomics.sh
  DESCEND objtool
  DESCEND bpf/resolve_btfids
  CC [M]  fs/nfsd/vfs.o
  CHECK   /home/cel/src/linux/manet/fs/nfsd/vfs.c
/home/cel/src/linux/manet/fs/nfsd/vfs.c: note: in included file (through /h=
ome/cel/src/linux/manet/include/linux/bitops.h, /home/cel/src/linux/manet/i=
nclude/linux/kernel.h, /home/cel/src/linux/manet/arch/x86/include/asm/percp=
u.h, ...):
/home/cel/src/linux/manet/arch/x86/include/asm/bitops.h:66:1: warning: unre=
placed symbol 'return'
/home/cel/src/linux/manet/fs/nfsd/vfs.c: note: in included file (through /h=
ome/cel/src/linux/manet/include/linux/bitops.h, /home/cel/src/linux/manet/i=
nclude/linux/kernel.h, /home/cel/src/linux/manet/arch/x86/include/asm/percp=
u.h, ...):
/home/cel/src/linux/manet/include/asm-generic/bitops/generic-non-atomic.h:2=
9:9: warning: unreplaced symbol 'mask'
/home/cel/src/linux/manet/include/asm-generic/bitops/generic-non-atomic.h:3=
0:9: warning: unreplaced symbol 'p'
/home/cel/src/linux/manet/include/asm-generic/bitops/generic-non-atomic.h:3=
2:10: warning: unreplaced symbol 'p'
/home/cel/src/linux/manet/include/asm-generic/bitops/generic-non-atomic.h:3=
2:16: warning: unreplaced symbol 'mask'
/home/cel/src/linux/manet/include/asm-generic/bitops/generic-non-atomic.h:2=
7:1: warning: unreplaced symbol 'return'
/home/cel/src/linux/manet/fs/nfsd/vfs.c: note: in included file (through /h=
ome/cel/src/linux/manet/arch/x86/include/asm/bitops.h, /home/cel/src/linux/=
manet/include/linux/bitops.h, /home/cel/src/linux/manet/include/linux/kerne=
l.h, ...):
/home/cel/src/linux/manet/include/asm-generic/bitops/instrumented-non-atomi=
c.h:26:1: warning: unreplaced symbol 'return'
/home/cel/src/linux/manet/fs/nfsd/vfs.c: note: in included file (through /h=
ome/cel/src/linux/manet/include/linux/bitops.h, /home/cel/src/linux/manet/i=
nclude/linux/kernel.h, /home/cel/src/linux/manet/arch/x86/include/asm/percp=
u.h, ...):
/home/cel/src/linux/manet/arch/x86/include/asm/bitops.h:92:1: warning: unre=
placed symbol 'return'
/home/cel/src/linux/manet/fs/nfsd/vfs.c: note: in included file (through /h=
ome/cel/src/linux/manet/include/linux/bitops.h, /home/cel/src/linux/manet/i=
nclude/linux/kernel.h, /home/cel/src/linux/manet/arch/x86/include/asm/percp=
u.h, ...):
/home/cel/src/linux/manet/include/asm-generic/bitops/generic-non-atomic.h:3=
8:9: warning: unreplaced symbol 'mask'
/home/cel/src/linux/manet/include/asm-generic/bitops/generic-non-atomic.h:3=
9:9: warning: unreplaced symbol 'p'
/home/cel/src/linux/manet/include/asm-generic/bitops/generic-non-atomic.h:4=
1:10: warning: unreplaced symbol 'p'
/home/cel/src/linux/manet/include/asm-generic/bitops/generic-non-atomic.h:4=
1:16: warning: unreplaced symbol 'mask'
/home/cel/src/linux/manet/include/asm-generic/bitops/generic-non-atomic.h:3=
6:1: warning: unreplaced symbol 'return'
/home/cel/src/linux/manet/fs/nfsd/vfs.c: note: in included file (through /h=
ome/cel/src/linux/manet/arch/x86/include/asm/bitops.h, /home/cel/src/linux/=
manet/include/linux/bitops.h, /home/cel/src/linux/manet/include/linux/kerne=
l.h, ...):
/home/cel/src/linux/manet/include/asm-generic/bitops/instrumented-non-atomi=
c.h:42:1: warning: unreplaced symbol 'return'
/home/cel/src/linux/manet/fs/nfsd/vfs.c: note: in included file (through /h=
ome/cel/src/linux/manet/include/linux/bitops.h, /home/cel/src/linux/manet/i=
nclude/linux/kernel.h, /home/cel/src/linux/manet/arch/x86/include/asm/percp=
u.h, ...):
/home/cel/src/linux/manet/arch/x86/include/asm/bitops.h:117:1: warning: unr=
eplaced symbol 'return'
/home/cel/src/linux/manet/fs/nfsd/vfs.c: note: in included file (through /h=
ome/cel/src/linux/manet/include/linux/bitops.h, /home/cel/src/linux/manet/i=
nclude/linux/kernel.h, /home/cel/src/linux/manet/arch/x86/include/asm/percp=
u.h, ...):
/home/cel/src/linux/manet/include/asm-generic/bitops/generic-non-atomic.h:5=
6:9: warning: unreplaced symbol 'mask'
/home/cel/src/linux/manet/include/asm-generic/bitops/generic-non-atomic.h:5=
7:9: warning: unreplaced symbol 'p'
/home/cel/src/linux/manet/include/asm-generic/bitops/generic-non-atomic.h:5=
9:10: warning: unreplaced symbol 'p'
/home/cel/src/linux/manet/include/asm-generic/bitops/generic-non-atomic.h:5=
9:15: warning: unreplaced symbol 'mask'
/home/cel/src/linux/manet/include/asm-generic/bitops/generic-non-atomic.h:5=
4:1: warning: unreplaced symbol 'return'
/home/cel/src/linux/manet/fs/nfsd/vfs.c: note: in included file (through /h=
ome/cel/src/linux/manet/arch/x86/include/asm/bitops.h, /home/cel/src/linux/=
manet/include/linux/bitops.h, /home/cel/src/linux/manet/include/linux/kerne=
l.h, ...):
/home/cel/src/linux/manet/include/asm-generic/bitops/instrumented-non-atomi=
c.h:58:1: warning: unreplaced symbol 'return'
/home/cel/src/linux/manet/fs/nfsd/vfs.c: note: in included file (through /h=
ome/cel/src/linux/manet/include/linux/bitops.h, /home/cel/src/linux/manet/i=
nclude/linux/kernel.h, /home/cel/src/linux/manet/arch/x86/include/asm/percp=
u.h, ...):
/home/cel/src/linux/manet/arch/x86/include/asm/bitops.h:150:9: warning: unr=
eplaced symbol 'oldbit'
/home/cel/src/linux/manet/arch/x86/include/asm/bitops.h:154:26: warning: un=
replaced symbol 'oldbit'
/home/cel/src/linux/manet/arch/x86/include/asm/bitops.h:156:16: warning: un=
replaced symbol 'oldbit'
/home/cel/src/linux/manet/arch/x86/include/asm/bitops.h:156:9: warning: unr=
eplaced symbol 'return'
/home/cel/src/linux/manet/arch/x86/include/asm/bitops.h:148:1: warning: unr=
eplaced symbol 'return'
/home/cel/src/linux/manet/fs/nfsd/vfs.c: note: in included file (through /h=
ome/cel/src/linux/manet/include/linux/bitops.h, /home/cel/src/linux/manet/i=
nclude/linux/kernel.h, /home/cel/src/linux/manet/arch/x86/include/asm/percp=
u.h, ...):
/home/cel/src/linux/manet/include/asm-generic/bitops/generic-non-atomic.h:7=
4:9: warning: unreplaced symbol 'mask'
/home/cel/src/linux/manet/include/asm-generic/bitops/generic-non-atomic.h:7=
5:9: warning: unreplaced symbol 'p'
/home/cel/src/linux/manet/include/asm-generic/bitops/generic-non-atomic.h:7=
6:9: warning: unreplaced symbol 'old'
/home/cel/src/linux/manet/include/asm-generic/bitops/generic-non-atomic.h:7=
8:10: warning: unreplaced symbol 'p'
/home/cel/src/linux/manet/include/asm-generic/bitops/generic-non-atomic.h:7=
8:14: warning: unreplaced symbol 'old'
/home/cel/src/linux/manet/include/asm-generic/bitops/generic-non-atomic.h:7=
8:20: warning: unreplaced symbol 'mask'
/home/cel/src/linux/manet/include/asm-generic/bitops/generic-non-atomic.h:7=
9:17: warning: unreplaced symbol 'old'
/home/cel/src/linux/manet/include/asm-generic/bitops/generic-non-atomic.h:7=
9:23: warning: unreplaced symbol 'mask'
/home/cel/src/linux/manet/include/asm-generic/bitops/generic-non-atomic.h:7=
9:9: warning: unreplaced symbol 'return'
/home/cel/src/linux/manet/include/asm-generic/bitops/generic-non-atomic.h:7=
2:1: warning: unreplaced symbol 'return'
/home/cel/src/linux/manet/fs/nfsd/vfs.c: note: in included file (through /h=
ome/cel/src/linux/manet/arch/x86/include/asm/bitops.h, /home/cel/src/linux/=
manet/include/linux/bitops.h, /home/cel/src/linux/manet/include/linux/kerne=
l.h, ...):
/home/cel/src/linux/manet/include/asm-generic/bitops/instrumented-non-atomi=
c.h:100:9: warning: unreplaced symbol 'return'
/home/cel/src/linux/manet/include/asm-generic/bitops/instrumented-non-atomi=
c.h:97:1: warning: unreplaced symbol 'return'
/home/cel/src/linux/manet/fs/nfsd/vfs.c: note: in included file (through /h=
ome/cel/src/linux/manet/include/linux/bitops.h, /home/cel/src/linux/manet/i=
nclude/linux/kernel.h, /home/cel/src/linux/manet/arch/x86/include/asm/percp=
u.h, ...):
/home/cel/src/linux/manet/arch/x86/include/asm/bitops.h:176:9: warning: unr=
eplaced symbol 'oldbit'
/home/cel/src/linux/manet/arch/x86/include/asm/bitops.h:180:35: warning: un=
replaced symbol 'oldbit'
/home/cel/src/linux/manet/arch/x86/include/asm/bitops.h:182:16: warning: un=
replaced symbol 'oldbit'
/home/cel/src/linux/manet/arch/x86/include/asm/bitops.h:182:9: warning: unr=
eplaced symbol 'return'
/home/cel/src/linux/manet/arch/x86/include/asm/bitops.h:174:1: warning: unr=
eplaced symbol 'return'
/home/cel/src/linux/manet/fs/nfsd/vfs.c: note: in included file (through /h=
ome/cel/src/linux/manet/include/linux/bitops.h, /home/cel/src/linux/manet/i=
nclude/linux/kernel.h, /home/cel/src/linux/manet/arch/x86/include/asm/percp=
u.h, ...):
/home/cel/src/linux/manet/include/asm-generic/bitops/generic-non-atomic.h:9=
4:9: warning: unreplaced symbol 'mask'
/home/cel/src/linux/manet/include/asm-generic/bitops/generic-non-atomic.h:9=
5:9: warning: unreplaced symbol 'p'
/home/cel/src/linux/manet/include/asm-generic/bitops/generic-non-atomic.h:9=
6:9: warning: unreplaced symbol 'old'
/home/cel/src/linux/manet/include/asm-generic/bitops/generic-non-atomic.h:9=
8:10: warning: unreplaced symbol 'p'
/home/cel/src/linux/manet/include/asm-generic/bitops/generic-non-atomic.h:9=
8:14: warning: unreplaced symbol 'old'
/home/cel/src/linux/manet/include/asm-generic/bitops/generic-non-atomic.h:9=
8:21: warning: unreplaced symbol 'mask'
/home/cel/src/linux/manet/include/asm-generic/bitops/generic-non-atomic.h:9=
9:17: warning: unreplaced symbol 'old'
/home/cel/src/linux/manet/include/asm-generic/bitops/generic-non-atomic.h:9=
9:23: warning: unreplaced symbol 'mask'
/home/cel/src/linux/manet/include/asm-generic/bitops/generic-non-atomic.h:9=
9:9: warning: unreplaced symbol 'return'
/home/cel/src/linux/manet/include/asm-generic/bitops/generic-non-atomic.h:9=
2:1: warning: unreplaced symbol 'return'
/home/cel/src/linux/manet/fs/nfsd/vfs.c: note: in included file (through /h=
ome/cel/src/linux/manet/arch/x86/include/asm/bitops.h, /home/cel/src/linux/=
manet/include/linux/bitops.h, /home/cel/src/linux/manet/include/linux/kerne=
l.h, ...):
/home/cel/src/linux/manet/include/asm-generic/bitops/instrumented-non-atomi=
c.h:115:9: warning: unreplaced symbol 'return'
/home/cel/src/linux/manet/include/asm-generic/bitops/instrumented-non-atomi=
c.h:112:1: warning: unreplaced symbol 'return'
/home/cel/src/linux/manet/fs/nfsd/vfs.c: note: in included file (through /h=
ome/cel/src/linux/manet/include/linux/bitops.h, /home/cel/src/linux/manet/i=
nclude/linux/kernel.h, /home/cel/src/linux/manet/arch/x86/include/asm/percp=
u.h, ...):
/home/cel/src/linux/manet/arch/x86/include/asm/bitops.h:188:9: warning: unr=
eplaced symbol 'oldbit'
/home/cel/src/linux/manet/arch/x86/include/asm/bitops.h:192:35: warning: un=
replaced symbol 'oldbit'
/home/cel/src/linux/manet/arch/x86/include/asm/bitops.h:195:16: warning: un=
replaced symbol 'oldbit'
/home/cel/src/linux/manet/arch/x86/include/asm/bitops.h:195:9: warning: unr=
eplaced symbol 'return'
/home/cel/src/linux/manet/arch/x86/include/asm/bitops.h:186:1: warning: unr=
eplaced symbol 'return'
/home/cel/src/linux/manet/fs/nfsd/vfs.c: note: in included file (through /h=
ome/cel/src/linux/manet/include/linux/bitops.h, /home/cel/src/linux/manet/i=
nclude/linux/kernel.h, /home/cel/src/linux/manet/arch/x86/include/asm/percp=
u.h, ...):
/home/cel/src/linux/manet/include/asm-generic/bitops/generic-non-atomic.h:1=
06:9: warning: unreplaced symbol 'mask'
/home/cel/src/linux/manet/include/asm-generic/bitops/generic-non-atomic.h:1=
07:9: warning: unreplaced symbol 'p'
/home/cel/src/linux/manet/include/asm-generic/bitops/generic-non-atomic.h:1=
08:9: warning: unreplaced symbol 'old'
/home/cel/src/linux/manet/include/asm-generic/bitops/generic-non-atomic.h:1=
10:10: warning: unreplaced symbol 'p'
/home/cel/src/linux/manet/include/asm-generic/bitops/generic-non-atomic.h:1=
10:14: warning: unreplaced symbol 'old'
/home/cel/src/linux/manet/include/asm-generic/bitops/generic-non-atomic.h:1=
10:20: warning: unreplaced symbol 'mask'
/home/cel/src/linux/manet/include/asm-generic/bitops/generic-non-atomic.h:1=
11:17: warning: unreplaced symbol 'old'
/home/cel/src/linux/manet/include/asm-generic/bitops/generic-non-atomic.h:1=
11:23: warning: unreplaced symbol 'mask'
/home/cel/src/linux/manet/include/asm-generic/bitops/generic-non-atomic.h:1=
11:9: warning: unreplaced symbol 'return'
/home/cel/src/linux/manet/include/asm-generic/bitops/generic-non-atomic.h:1=
04:1: warning: unreplaced symbol 'return'
/home/cel/src/linux/manet/fs/nfsd/vfs.c: note: in included file (through /h=
ome/cel/src/linux/manet/arch/x86/include/asm/bitops.h, /home/cel/src/linux/=
manet/include/linux/bitops.h, /home/cel/src/linux/manet/include/linux/kerne=
l.h, ...):
/home/cel/src/linux/manet/include/asm-generic/bitops/instrumented-non-atomi=
c.h:130:9: warning: unreplaced symbol 'return'
/home/cel/src/linux/manet/include/asm-generic/bitops/instrumented-non-atomi=
c.h:127:1: warning: unreplaced symbol 'return'
/home/cel/src/linux/manet/fs/nfsd/vfs.c: note: in included file (through /h=
ome/cel/src/linux/manet/include/linux/bitops.h, /home/cel/src/linux/manet/i=
nclude/linux/kernel.h, /home/cel/src/linux/manet/arch/x86/include/asm/percp=
u.h, ...):
/home/cel/src/linux/manet/arch/x86/include/asm/bitops.h:225:9: warning: unr=
eplaced symbol 'return'
/home/cel/src/linux/manet/arch/x86/include/asm/bitops.h:223:1: warning: unr=
eplaced symbol 'return'
/home/cel/src/linux/manet/fs/nfsd/vfs.c: note: in included file (through /h=
ome/cel/src/linux/manet/include/linux/bitops.h, /home/cel/src/linux/manet/i=
nclude/linux/kernel.h, /home/cel/src/linux/manet/arch/x86/include/asm/percp=
u.h, ...):
/home/cel/src/linux/manet/include/asm-generic/bitops/generic-non-atomic.h:1=
27:9: warning: unreplaced symbol 'return'
/home/cel/src/linux/manet/include/asm-generic/bitops/generic-non-atomic.h:1=
20:1: warning: unreplaced symbol 'return'
/home/cel/src/linux/manet/include/asm-generic/bitops/generic-non-atomic.h:1=
54:9: warning: unreplaced symbol 'p'
/home/cel/src/linux/manet/include/asm-generic/bitops/generic-non-atomic.h:1=
55:9: warning: unreplaced symbol 'mask'
/home/cel/src/linux/manet/include/asm-generic/bitops/generic-non-atomic.h:1=
56:9: warning: unreplaced symbol 'val'
/home/cel/src/linux/manet/include/asm-generic/bitops/generic-non-atomic.h:1=
58:19: warning: unreplaced symbol 'val'
/home/cel/src/linux/manet/include/asm-generic/bitops/generic-non-atomic.h:1=
58:25: warning: unreplaced symbol 'mask'
/home/cel/src/linux/manet/include/asm-generic/bitops/generic-non-atomic.h:1=
58:9: warning: unreplaced symbol 'return'
/home/cel/src/linux/manet/include/asm-generic/bitops/generic-non-atomic.h:1=
52:1: warning: unreplaced symbol 'return'
/home/cel/src/linux/manet/fs/nfsd/vfs.c: note: in included file (through /h=
ome/cel/src/linux/manet/arch/x86/include/asm/bitops.h, /home/cel/src/linux/=
manet/include/linux/bitops.h, /home/cel/src/linux/manet/include/linux/kerne=
l.h, ...):
/home/cel/src/linux/manet/include/asm-generic/bitops/instrumented-non-atomi=
c.h:142:9: warning: unreplaced symbol 'return'
/home/cel/src/linux/manet/include/asm-generic/bitops/instrumented-non-atomi=
c.h:139:1: warning: unreplaced symbol 'return'
make[1]: Leaving directory '/usr/obj/manet.1015granger.net'
[cel@manet manet]$


--
Chuck Lever



