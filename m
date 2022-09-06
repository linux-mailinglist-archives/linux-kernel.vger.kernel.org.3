Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8E95AF4C7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiIFTtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiIFTtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:49:04 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FC89674C
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:49:01 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286Id93h019957;
        Tue, 6 Sep 2022 19:48:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2022-7-12;
 bh=624OAWBQQHpkGuZtT/TImiZwBAVjzeD6NANm4xupRTU=;
 b=WMFJe9DSTselvfFxhdAK6NTT/z/dsYn5OiUWR2ZBKwBWVs/nuf5fhsYP9/B01OYIHjf4
 bqgLlXcE0elom3T5bpOTyEPB2YocaNEPQWs/k7IHOcsdKk45dV4uiFR5OxDTgFI7i0zr
 5MTdjzJN3z8GSUtBsR1Sb6jhebVvf3NI+saW0kHe1FjPPH10GuBBup6XaD+k+QTwJ2YE
 6r3J5puCp0Gzh4M9FzLloydxDOB2S+m9Lm9INA0bVJq6GI0IKS3t3rTkl7Bs295/Ld85
 G0FRognDgKn25201cUp/mtp7AZlQ5O1ALSWjEpz07TCisabfeGHvmGKnP8gMsLr0OPl0 dQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwh1exj4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:48:41 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286IAo1n037532;
        Tue, 6 Sep 2022 19:48:40 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc32vn7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:48:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kylKYE8XG8XAXrRyuDUlIl+EKwQllm+q2cIYSrS9+pZNul+p/LQaWrJDeojbPy/a1TzBjqxSLbZ2I+2pCm6cckP8xlTVwU66mlO4Cw+TliZyeFWBZTF30mehywGF2E+1n333CJu1HYRX00f7rk1ys80XRxjlUKxtTGmXTJasSEzuBGAbf3kYjwOHfZLKsKVV+uCln4CEjvQlwkHdjfeHLhYUhYNZeI46P4JiWpukHUfdIz20e4zMf0uETFR8L3uaIlNjJqM9OptnuPaYqrQnFtH/QHcvCr9Zd9PAy1D1GUgZu1W8EoG9uJJJt/kGCujmSC+LAu9MA1F2gJ1DLzjKCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=624OAWBQQHpkGuZtT/TImiZwBAVjzeD6NANm4xupRTU=;
 b=bVRclYsqhtKgkiPRlwMOTDYATUZZXx47KxihVjziwy1bo/EE8GfuhaL5yhOoai5mWCaJW1c3GY9IGuT7DJYiQ7yYbix0kmGuQfb5vqfxlCV3gBYrK8BgICrgW4B7qtNBcnGLA5ESUP15mLTZ7tCubS7co0JCZdkdGF+fxdITyMJ4abiJmvqI76G/9fHUeVt5NLzRhDnV2JMuUX8fMv8ipWW4eQMsDJqrs/ls4CtWtS1E07Lb8/wIQ6PRYGelJccW+DoItxUILnQ4dVbJe2pwP6n1gg27Ne6c2rysLf7RZc8g4HBXQQZPlz4CDxQFMRofa+Cy/ZR+AEMocnOHqTn4YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=624OAWBQQHpkGuZtT/TImiZwBAVjzeD6NANm4xupRTU=;
 b=NWyzEdJDTkUK7+gPPlY8vrrjQx2y6dyv9ASbZxqR3LQgwQ4qNXQKB3x5fh0+Fg1E80AWvx/xPWmsdsncCLiDF5Xi7UoH9T4d5kMkGKsRXeTgwwNlMTQRTdi+JRFqUalrG8DveT1qmwxLnOrjdUVnALEOWHqVYbbfmpYhs0BbmM8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM4PR10MB6840.namprd10.prod.outlook.com (2603:10b6:8:104::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 19:48:38 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223%5]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 19:48:38 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v14 00/70] Introducing the Maple Tree
Thread-Topic: [PATCH v14 00/70] Introducing the Maple Tree
Thread-Index: AQHYwimon9+qH6EC0EalpC37Vnej1A==
Date:   Tue, 6 Sep 2022 19:48:38 +0000
Message-ID: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae4fbf18-7359-49ee-bada-08da9040cae3
x-ms-traffictypediagnostic: DM4PR10MB6840:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qD+jnYttIQhPdTLBhF83YxIEDzjxp7qeO1vMBeeewhPOI9Fc7zaUn3aAMmqPEpamAuJm6vVs/wa9DrN1TgnBpyg7Td3Xhl4Aj7lXnontJN/gV1Byzh7YF/K0mUuySPLisi2qAnVzl/Lnfyq3HrES077rxRgZIL5aA594B2MuVzAvshZQO58l9VCKo1d7ZHHkiyIgzmnIvbTiRKpzPL874Ek9fgdJtTlTJJvNMBsywyz9XikVcjjEpg2a5fM19E4YYByzrjVqbqC3vBLicpRKhlIbGSdLl83P6+6XsNWHb0GAih8XIRgDzyMyOmmCaKb+Lnb8ZoXCqtwPXiPW7hUam3l2gnz7pRGKn8siKS1JR6sq99lbGl2hhhHaFHjklAnhNLGYSO6ftQedBft6KRdxGFNy2HxTDKI0Rm9j02SyjhfwGQTAcmIyGsIlMFfM53DydHKCUCUUTIfzsIadZfmF5uLmQXTEZD12a+ajx5bwBGBIUBjagfqhMciJg+q2HPKVWxfCrFPgJbylU30dVE8EdE3h87Kz+LfKbhuTD7jWz3sJ4sn5Tr5fv1pbptPaPhqFY0RdJ3F4iY846iy9QJEKmTk9nJtqdOY4PhlkvXqVuEbsuweqtg+grf5YM/KJB+/VsQw+0E6hDxMgWCbatofmDcZjquTXIKcbGxWkD0hxDVmqHkMdRbIsm/ueyOewgGBbd+71bZE85OE53wQhTBoP/jgA4ywx0hGOr5uwu2zl2yj9CYECGcw6QMDUckYAQvR5+86Jc5nuSKzeiHYmcWS1pnJmaqiY2Vufjxg5G0Xx2nyW13a2vzP/+pRr5kfTmYcpSEiiKYjrX2mQPH/KHTIDyQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(376002)(39860400002)(136003)(396003)(38070700005)(2906002)(83380400001)(2616005)(1076003)(186003)(71200400001)(64756008)(122000001)(36756003)(316002)(6486002)(66946007)(66556008)(4326008)(66476007)(8676002)(76116006)(966005)(91956017)(478600001)(66446008)(110136005)(26005)(6506007)(6512007)(8936002)(5660300002)(44832011)(107886003)(41300700001)(38100700002)(86362001)(30864003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?pehSgHxB5Ze9fh6zCAlJEeEVhN2bNXBBuMfi1KwQ1O2tjginc3tWRRuDFT?=
 =?iso-8859-1?Q?w4lZgbWPwrFwDuAaofiYo4g7Al30joOdhwQzkf1Jh768CMpsuVaEiKE0IZ?=
 =?iso-8859-1?Q?bVqIOFzhwHCPqwa86hxiJvG0r275DPIuPNVZ9xBtUwoIc2PEtSMYZDOYup?=
 =?iso-8859-1?Q?m1TCnLxRTPp6phtmqvNbBJpZ3f/d0hdachExP9SjDUD8eXnJCdkjpDZ2+f?=
 =?iso-8859-1?Q?xoU0CD/eBmd7XKOl4kfiSPBo2wvkO03Ktaq9EYWv3eNdSSBfBgdoFhYvhN?=
 =?iso-8859-1?Q?ixbnzwZNDmP9e0YO6d8mlvx2F1py4qpbupCViGP5cCb2NPrNE3QrztIKnu?=
 =?iso-8859-1?Q?VR4mMGmsRuoi50klqT9oniDdbKW2ezLjm5R++CmJ05HJhKhNuNStjUseS+?=
 =?iso-8859-1?Q?6wKis/0X8rv2RsMoPJPuoD+9XILhpVph3Ib/bU1Il4gQ35grdELcldID8w?=
 =?iso-8859-1?Q?U8G3u7IEmu+/PlD+ZMCbVIYO+ipm4sxDSX6yWCyGFCbGiPS4P7wiuY5HBh?=
 =?iso-8859-1?Q?EePLO/QcQ+F+iBL8kioSVZzkrSerw29DFYHaoQoZAe+YtWjpbJw3wfyWxJ?=
 =?iso-8859-1?Q?2V10SZX/0XDqn3kfegwBc9VIHx/xtyNvAR7zWZ+W0Du92uCGCzoIijDnzZ?=
 =?iso-8859-1?Q?OeCQngq2QF4W5AapukeeLQznEdMEezXOocNW408A5IvCyMHvM31+AdOMQD?=
 =?iso-8859-1?Q?uMv7D55Btd7yco0X8C4NArlclqrPyl6FEnlaVNzJF5EAUIEhA/nmokCpom?=
 =?iso-8859-1?Q?GqwQUBKqHMcjtUMrwRvjrgF7cqS+UjMeumZz0Y62p4jjc8sgS4BZCneZfy?=
 =?iso-8859-1?Q?zXlVWWmY9MLR91BHg/5mGFHpswMShTEZXD8naJmiU3pHqWJH6ZxtvIExLQ?=
 =?iso-8859-1?Q?jm3l2PDUn/M6TiZY5w5C5cVTqAbCRce5VMoSwuluGHLMIyekf16iS31YWM?=
 =?iso-8859-1?Q?5IlaWYJuOHPaOHIaVAfRhnpS/mSizX8goK7BHK2YzQe1drHa3PmJWCJW38?=
 =?iso-8859-1?Q?UNnvGMIZ+YAAL3xxZf2Dd6PqtaILsUwW8ksuJv5OVfk5ExOqpQp/f4AVKp?=
 =?iso-8859-1?Q?+5m9EeEgq9qChFFGNf40y8rNDnMmpG2N9tsiDPRUVRmgrvLWV/I35L+IP9?=
 =?iso-8859-1?Q?65pAxLkZRxmLEqhpAuPtZDBIuk6hZo5BPJLPlSlcMLXsJNwvvHaSp7p9iw?=
 =?iso-8859-1?Q?e3DoIPINqIIW9emnx+v+Tv38Vsej5+vMYCbckNDTBA8UcPndDL7dgiViJK?=
 =?iso-8859-1?Q?bt/d22cdJElrUlw7smjIt6MKmKcFsSsvy787jlCkUnsLdt3svw5e/UM5Sx?=
 =?iso-8859-1?Q?8dK6yb8dXLBX9PKKcnyjgk8Qxix8KJwMKE4JohUVlvQa8PZj3tQkFxH2WO?=
 =?iso-8859-1?Q?qbRAHm6q9H1XyEM8dzCM3xE4ix3y+cn+2IQ3Jv2JUl36oUKCLH9FSxsXdx?=
 =?iso-8859-1?Q?FspQR+gD9PKuI7FXR4iHc8S2MknDN5FF1OPjH510kdcVkYNvf/zUqMnbSo?=
 =?iso-8859-1?Q?AqxcWhy2jeX6Zk+9srTXA1BcOGvIFvmULHMktxWVtS86bBStAUDpMj2PKe?=
 =?iso-8859-1?Q?8XdKjPC1a/+FSbVdBEq7YYPFlrxBGiS2IerD9lRV/dAjrpwr5P6R4CBJUo?=
 =?iso-8859-1?Q?GrtGf6OGPRdCY2G0i2wZPAWhugZcGc4YLar3AfeDz75GGdRTArxnLocQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae4fbf18-7359-49ee-bada-08da9040cae3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 19:48:38.2262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7ezB6BFvRpd9Otde64U425lNQ3QBKGqbFWLoAdV8l4+efJyXExnDqcSc0l+wlWj3h0qDYnNIDtqnp6hADmx1QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6840
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209060091
X-Proofpoint-GUID: XXX4APN7ZDC-t9-S2JlgZGLZ9m2NT6lD
X-Proofpoint-ORIG-GUID: XXX4APN7ZDC-t9-S2JlgZGLZ9m2NT6lD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is the v13 + fixes and still based against mm-unstable
v6.0-rc1-140-geb22a5b1b495

git: https://github.com/oracle/linux-uek/tree/howlett/maple/20220906

Patch series "Introducing the Maple Tree".

The maple tree is an RCU-safe range based B-tree designed to use modern
processor cache efficiently.  There are a number of places in the kernel
that a non-overlapping range-based tree would be beneficial, especially
one with a simple interface.  If you use an rbtree with other data
structures to improve performance or an interval tree to track
non-overlapping ranges, then this is for you.

The tree has a branching factor of 10 for non-leaf nodes and 16 for leaf
nodes.  With the increased branching factor, it is significantly shorter
than the rbtree so it has fewer cache misses.  The removal of the linked
list between subsequent entries also reduces the cache misses and the need
to pull in the previous and next VMA during many tree alterations.

The first user that is covered in this patch set is the vm_area_struct,
where three data structures are replaced by the maple tree: the augmented
rbtree, the vma cache, and the linked list of VMAs in the mm_struct.  The
long term goal is to reduce or remove the mmap_lock contention.

The plan is to get to the point where we use the maple tree in RCU mode.
Readers will not block for writers.  A single write operation will be
allowed at a time.  A reader re-walks if stale data is encountered.  VMAs
would be RCU enabled and this mode would be entered once multiple tasks
are using the mm_struct.

Davidlohr said

: Yes I like the maple tree, and at this stage I don't think we can ask for
: more from this series wrt the MM - albeit there seems to still be some
: folks reporting breakage.  Fundamentally I see Liam's work to (re)move
: complexity out of the MM (not to say that the actual maple tree is not
: complex) by consolidating the three complimentary data structures very
: much worth it considering performance does not take a hit.  This was very
: much a turn off with the range locking approach, which worst case scenari=
o
: incurred in prohibitive overhead.  Also as Liam and Matthew have
: mentioned, RCU opens up a lot of nice performance opportunities, and in
: addition academia[1] has shown outstanding scalability of address spaces
: with the foundation of replacing the locked rbtree with RCU aware trees.

A similar work has been discovered in the academic press

	https://pdos.csail.mit.edu/papers/rcuvm:asplos12.pdf

Sheer coincidence.  We designed our tree with the intention of solving the
hardest problem first.  Upon settling on a b-tree variant and a rough
outline, we researched ranged based b-trees and RCU b-trees and did find
that article.  So it was nice to find reassurances that we were on the
right path, but our design choice of using ranges made that paper unusable
for us.

Changes:
 - Documentation warning fix - Thanks Stephen Rothwell
 - Fixed mlock start address when memory tags are used - Mark Brown &
   Catalin Marinas
 - Added fix to nommu from Yang Yingliang
 - Added git commit messages for mprotect, mremap, oom_kill, and
 mremap iterating - Thanks Davidlohr Bueso
 - Added more information to the test_maple_tree.c git change log -
   Thanks Davidlohr Bueso
 - Change fs/proc/base to vmi iterator - Thanks Davidlohr Bueso
 - Minor cleanup to mm/khugepaged patch - Thanks Davidlohr Bueso
 - Added more Reviewed-by - Thanks Davidlohr Bueso
 - Added note about BUG_ON()s to git change log - Thanks Andrew Morton
 - Fixed accounting error internal to the patch set to mm->map_count in
   do_brk_flags()
=20
v13: https://lore.kernel.org/linux-mm/20220822150128.1562046-1-Liam.Howlett=
@oracle.com/
v12: https://lore.kernel.org/linux-mm/20220720021727.17018-1-Liam.Howlett@o=
racle.com/
v11: https://lore.kernel.org/linux-mm/20220717024615.2106835-1-Liam.Howlett=
@oracle.com/
v10: https://lore.kernel.org/linux-mm/20220621204632.3370049-1-Liam.Howlett=
@oracle.com/
v9: https://lore.kernel.org/lkml/20220504010716.661115-1-Liam.Howlett@oracl=
e.com/
...and
https://lore.kernel.org/lkml/20220504011215.661968-1-Liam.Howlett@oracle.co=
m/

v8: https://lore.kernel.org/lkml/20220426150616.3937571-1-Liam.Howlett@orac=
le.com/
v7: https://lore.kernel.org/linux-mm/20220404143501.2016403-8-Liam.Howlett@=
oracle.com/
v6: https://lore.kernel.org/linux-mm/20220215143728.3810954-1-Liam.Howlett@=
oracle.com/
v5: https://lore.kernel.org/linux-mm/20220202024137.2516438-1-Liam.Howlett@=
oracle.com/
v4: https://lore.kernel.org/linux-mm/20211201142918.921493-1-Liam.Howlett@o=
racle.com/
v3: https://lore.kernel.org/linux-mm/20211005012959.1110504-1-Liam.Howlett@=
oracle.com/
v2: https://lore.kernel.org/linux-mm/20210817154651.1570984-1-Liam.Howlett@=
oracle.com/
v1: https://lore.kernel.org/linux-mm/20210428153542.2814175-1-Liam.Howlett@=
Oracle.com/

Liam R. Howlett (45):
  Maple Tree: add new data structure
  radix tree test suite: add pr_err define
  radix tree test suite: add kmem_cache_set_non_kernel()
  radix tree test suite: add allocation counts and size to kmem_cache
  radix tree test suite: add support for slab bulk APIs
  radix tree test suite: add lockdep_is_held to header
  lib/test_maple_tree: add testing for maple tree
  mm: start tracking VMAs with maple tree
  mm/mmap: use the maple tree in find_vma() instead of the rbtree.
  mm/mmap: use the maple tree for find_vma_prev() instead of the rbtree
  mm/mmap: use maple tree for unmapped_area{_topdown}
  kernel/fork: use maple tree for dup_mmap() during forking
  damon: convert __damon_va_three_regions to use the VMA iterator
  mm: remove rb tree.
  mmap: change zeroing of maple tree in __vma_adjust()
  xen: use vma_lookup() in privcmd_ioctl_mmap()
  mm: optimize find_exact_vma() to use vma_lookup()
  mm/khugepaged: optimize collapse_pte_mapped_thp() by using
    vma_lookup()
  mm/mmap: change do_brk_flags() to expand existing VMA and add
    do_brk_munmap()
  mm: use maple tree operations for find_vma_intersection()
  mm/mmap: use advanced maple tree API for mmap_region()
  mm: remove vmacache
  mm: convert vma_lookup() to use mtree_load()
  mm/mmap: move mmap_region() below do_munmap()
  mm/mmap: reorganize munmap to use maple states
  mm/mmap: change do_brk_munmap() to use do_mas_align_munmap()
  arm64: Change elfcore for_each_mte_vma() to use VMA iterator
  fs/proc/base: use the vma iterators in place of linked list
  userfaultfd: use maple tree iterator to iterate VMAs
  ipc/shm: use VMA iterator instead of linked list
  bpf: remove VMA linked list
  mm/gup: use maple tree navigation instead of linked list
  mm/madvise: use vma_find() instead of vma linked list
  mm/memcontrol: stop using mm->highest_vm_end
  mm/mempolicy: use vma iterator & maple state instead of vma linked
    list
  mm/mprotect: use maple tree navigation instead of VMA linked list
  mm/mremap: use vma_find_intersection() instead of vma linked list
  mm/msync: use vma_find() instead of vma linked list
  mm/oom_kill: use vma iterators instead of vma linked list
  mm/swapfile: use vma iterator instead of vma linked list
  riscv: use vma iterator for vdso
  mm/vmscan: Use vma iterator instead of vm_next
  mm: remove the vma linked list
  mm/mmap: drop range_has_overlap() function
  mm/mmap.c: pass in mapping to __vma_link_file()

Matthew Wilcox (Oracle) (25):
  mm: add VMA iterator
  mmap: use the VMA iterator in count_vma_pages_range()
  proc: remove VMA rbtree use from nommu
  arm64: remove mmap linked list from vdso
  parisc: remove mmap linked list from cache handling
  powerpc: remove mmap linked list walks
  s390: remove vma linked list walks
  x86: remove vma linked list walks
  xtensa: remove vma linked list walks
  cxl: remove vma linked list walk
  optee: remove vma linked list walk
  um: remove vma linked list walk
  coredump: remove vma linked list walk
  exec: use VMA iterator instead of linked list
  fs/proc/task_mmu: stop using linked list and highest_vm_end
  acct: use VMA iterator instead of linked list
  perf: use VMA iterator
  sched: use maple tree iterator to walk VMAs
  fork: use VMA iterator
  mm/khugepaged: stop using vma linked list
  mm/ksm: use vma iterators instead of vma linked list
  mm/mlock: use vma iterator and maple state instead of vma linked list
  mm/pagewalk: use vma_find() instead of vma linked list
  i915: use the VMA iterator
  nommu: remove uses of VMA linked list

 Documentation/core-api/index.rst              |     1 +
 Documentation/core-api/maple_tree.rst         |   217 +
 MAINTAINERS                                   |    12 +
 arch/arm64/kernel/elfcore.c                   |    16 +-
 arch/arm64/kernel/vdso.c                      |     3 +-
 arch/parisc/kernel/cache.c                    |     9 +-
 arch/powerpc/kernel/vdso.c                    |     6 +-
 arch/powerpc/mm/book3s32/tlb.c                |    11 +-
 arch/powerpc/mm/book3s64/subpage_prot.c       |    13 +-
 arch/riscv/kernel/vdso.c                      |     3 +-
 arch/s390/kernel/vdso.c                       |     3 +-
 arch/s390/mm/gmap.c                           |     6 +-
 arch/um/kernel/tlb.c                          |    14 +-
 arch/x86/entry/vdso/vma.c                     |     9 +-
 arch/x86/kernel/tboot.c                       |     2 +-
 arch/xtensa/kernel/syscall.c                  |    18 +-
 drivers/firmware/efi/efi.c                    |     2 +-
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c   |    14 +-
 drivers/misc/cxl/fault.c                      |    45 +-
 drivers/tee/optee/call.c                      |    18 +-
 drivers/xen/privcmd.c                         |     2 +-
 fs/coredump.c                                 |    34 +-
 fs/exec.c                                     |    12 +-
 fs/proc/base.c                                |     5 +-
 fs/proc/internal.h                            |     2 +-
 fs/proc/task_mmu.c                            |    74 +-
 fs/proc/task_nommu.c                          |    45 +-
 fs/userfaultfd.c                              |    62 +-
 include/linux/maple_tree.h                    |   685 +
 include/linux/mm.h                            |    78 +-
 include/linux/mm_types.h                      |    43 +-
 include/linux/mm_types_task.h                 |    12 -
 include/linux/sched.h                         |     1 -
 include/linux/userfaultfd_k.h                 |     7 +-
 include/linux/vm_event_item.h                 |     4 -
 include/linux/vmacache.h                      |    28 -
 include/linux/vmstat.h                        |     6 -
 include/trace/events/maple_tree.h             |   123 +
 include/trace/events/mmap.h                   |    73 +
 init/main.c                                   |     2 +
 ipc/shm.c                                     |    21 +-
 kernel/acct.c                                 |    11 +-
 kernel/bpf/task_iter.c                        |    10 +-
 kernel/debug/debug_core.c                     |    12 -
 kernel/events/core.c                          |     3 +-
 kernel/events/uprobes.c                       |     9 +-
 kernel/fork.c                                 |    62 +-
 kernel/sched/fair.c                           |    10 +-
 lib/Kconfig.debug                             |    17 +-
 lib/Makefile                                  |     2 +-
 lib/maple_tree.c                              |  7130 +++
 lib/test_maple_tree.c                         | 38307 ++++++++++++++++
 mm/Makefile                                   |     2 +-
 mm/damon/vaddr-test.h                         |    36 +-
 mm/damon/vaddr.c                              |    53 +-
 mm/debug.c                                    |    14 +-
 mm/gup.c                                      |     7 +-
 mm/huge_memory.c                              |     4 +-
 mm/init-mm.c                                  |     4 +-
 mm/internal.h                                 |     8 +-
 mm/khugepaged.c                               |    11 +-
 mm/ksm.c                                      |    18 +-
 mm/madvise.c                                  |     2 +-
 mm/memcontrol.c                               |     6 +-
 mm/memory.c                                   |    33 +-
 mm/mempolicy.c                                |    56 +-
 mm/mlock.c                                    |    35 +-
 mm/mmap.c                                     |  2154 +-
 mm/mprotect.c                                 |     8 +-
 mm/mremap.c                                   |    22 +-
 mm/msync.c                                    |     2 +-
 mm/nommu.c                                    |   260 +-
 mm/oom_kill.c                                 |     3 +-
 mm/pagewalk.c                                 |     2 +-
 mm/swapfile.c                                 |     4 +-
 mm/util.c                                     |    32 -
 mm/vmacache.c                                 |   117 -
 mm/vmscan.c                                   |    15 +-
 mm/vmstat.c                                   |     4 -
 tools/include/linux/slab.h                    |     4 +
 tools/testing/radix-tree/.gitignore           |     2 +
 tools/testing/radix-tree/Makefile             |     9 +-
 tools/testing/radix-tree/generated/autoconf.h |     1 +
 tools/testing/radix-tree/linux.c              |   160 +-
 tools/testing/radix-tree/linux/kernel.h       |     1 +
 tools/testing/radix-tree/linux/lockdep.h      |     2 +
 tools/testing/radix-tree/linux/maple_tree.h   |     7 +
 tools/testing/radix-tree/maple.c              |    59 +
 .../radix-tree/trace/events/maple_tree.h      |     5 +
 89 files changed, 48581 insertions(+), 1895 deletions(-)
 create mode 100644 Documentation/core-api/maple_tree.rst
 create mode 100644 include/linux/maple_tree.h
 delete mode 100644 include/linux/vmacache.h
 create mode 100644 include/trace/events/maple_tree.h
 create mode 100644 lib/maple_tree.c
 create mode 100644 lib/test_maple_tree.c
 delete mode 100644 mm/vmacache.c
 create mode 100644 tools/testing/radix-tree/linux/maple_tree.h
 create mode 100644 tools/testing/radix-tree/maple.c
 create mode 100644 tools/testing/radix-tree/trace/events/maple_tree.h

--=20
2.35.1
