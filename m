Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737DD5192CC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 02:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237997AbiEDAaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 20:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234630AbiEDAaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 20:30:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79189140A6
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 17:26:33 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243L4Hg5018680;
        Wed, 4 May 2022 00:26:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=uJXZqMwrFEwueO7Sfnlb9F+e/qCnfHV2Z+JbPEvnYxI=;
 b=YGZsEOPv/+6cidYPD03byV9anPqz7P/5lp73Nv73b6YWcaI2CtK1UKGZiDMwTI3ns5rY
 X2gAAmWQzDigi/dY3AFaHJflCUJyiPh9aWuTmxMB+pjSS1cL4zm0KyPnxvbB0rDwj+3K
 8HTP7jXYAtjfl9Q5BI4Tc7qk/CE4q5c8AUeMdGHEZaTtxE7JIdm0bakSpytBZnrO1hLR
 Cz9WoVht/PHG+04uUtSthjtyJGx5LxWvRsHoielfVX0uWmcA5i//Vvs7daMZ5Lk3OtWw
 ntrFZwSBubxaS9bNURoN4TAodww+WY8spqYPSMMgayH+SniiLUg4WLqDn6RruOQC+Put Ng== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frwnt733d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 00:26:27 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2440EnKV022186;
        Wed, 4 May 2022 00:26:27 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2173.outbound.protection.outlook.com [104.47.73.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fruj2v559-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 00:26:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E8RyQEcTamZdc2q49W8jcQSN3ZXLMetP8YJ/ZSO2dMsKBZKjOtC/ueRRVkA/YyJmsP6d6Oto3jKVAQxbqS4bHx9ZiRFZWgetEGa5aRKfohHiGu36SKErE076q4lbuqQJMKqRiw0Otz6D+Ntj/9quBBgx53cXH4llnLhsKg9oVXsuCCyYVrZnYNhHBHB2Fmwl9yHWdvrxRFETUfJFbJh+Xy6IZl4/WkLMdSU+TC01M+vGEssKfzunC2VfAbnVFNbOPMGIu49cdEDiiJ2MSy19WwerT7sGHjyFTefVX6+Pg+3b1YrRTQTfGSFhHSPno8XgNRFb5seCW0SOQfvqc7TuBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uJXZqMwrFEwueO7Sfnlb9F+e/qCnfHV2Z+JbPEvnYxI=;
 b=gtOvDCl5BTcXLU/r1EdbQRiVpqBF3XW2I6XiRWz7Rx+d/oZ0cd/i2usKGh60Lu+kUipXugm7pxqA94Ye0oaWEJOi+fYjeGqDubU8ow5UEeP8NuZMcUKgNqRJx5j8thdNjyaDIMK2Lba5O4V24Qaz2UKw5gxRPtx7S3NlNIZz7yGXgLm/DcaW5aYjTL3B2XSeDmFPr+oaIbuav39RrlXph60XfI1ED3nweCp2oXvkGZe24p/oORq16K7Pe39jKbuQFxIEvLEhn4rz7nwjH/YorfUOfHwCyFX/KUUNFL6Qvdss2KBde3wNtrEoE0Y+2hfjequHSsgm6kOyLzLOlOiKBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJXZqMwrFEwueO7Sfnlb9F+e/qCnfHV2Z+JbPEvnYxI=;
 b=bT9drGKRLrWBg1U0DY5lQhtFvdoV5DkyZ9j3MEuWXIvYlaJ7vj2TKTFyFAgVlDH1NgBtqnkWG63iQLURlz3gZL9XNn0vg986WxYX7cNWpQ75kPaeVc1GA1W2z/PojoMkd8aqSU1zihYlo2aWboQorOIsmqO6Pc0PVlDKlYTaA6M=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB3081.namprd10.prod.outlook.com (2603:10b6:5:62::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.17; Wed, 4 May
 2022 00:26:25 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 00:26:24 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/1] Prepare for maple tree
Thread-Topic: [PATCH 0/1] Prepare for maple tree
Thread-Index: AQHYX02VlXwjgoyqW0WAbyIZW9nffg==
Date:   Wed, 4 May 2022 00:26:24 +0000
Message-ID: <20220504002554.654642-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9e43a0b3-16fe-4786-efb9-08da2d64b8ef
x-ms-traffictypediagnostic: DM6PR10MB3081:EE_
x-microsoft-antispam-prvs: <DM6PR10MB3081A0A115F08D7EA8660CCAFDC39@DM6PR10MB3081.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vXrTrIijK8SU0CkGYJcS8bCju6Y2JhbETFOlM25pA9jafjq/YQMi4hjBh0SXZ0uxI1T9s4sW93dgHzSdJa1GTydvYIYHOp/fBeyH+YEFUYdjMSZERZUr7wkCFOMgHCUxyPScMaF4ItlMA927NOZYsHYXDxLDAWQyO2OwJb9vQ3CqHm/QpwsiTcQ8Ndj9ACxpiVIWX0uOG85qD1itbuVFreTlhHFbufOt+7rivxkRUsP39+Dy/bzdB2Q4aAOkW8R63jikl2kKtgIYOV0ZXzqvalaea7oMpFBcQ4rcQmyLQIeJmKx3kMolo6cw6PCJAJyAvMi4/mWUaScddTETJ/b++xd5lDwf2bCSXqYYP/snnsVqPsJBW3//F4UEzSokjDUoiG+bJ34F2Eq9l01j/Q8KkM9DAqK0PT6qOIHQ9GCpZMqkL7YSvcs5hUMXmN0SJ+R4rVd1EaGuYT+CulpAd1TvKwS+9dBq0Qf4K/ODYbcqscz7W+Rmj7KmEMY6p85hjlqQTWiHjxLKVMw0c6gI2m4Xa+cV6Y0yg/4sblaFumyvOVjB6e8Us4C4kKQ5PfeSkBlu7Va4/0gDwjGneguOwXqqies008m4q0RvjeKJCMu+VOstyW9wkMVaXN3pvmQzfHUyoHdStWFm6iyFLIGFH9UemQ+dsyw4TNCoOnwcPOCrvCI2/N4XQmB5mgdK8AfIgUeGwP2RISWFV/r7E3kieZ6p1Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(6486002)(83380400001)(508600001)(66446008)(66946007)(66556008)(66476007)(8676002)(110136005)(71200400001)(76116006)(8936002)(44832011)(316002)(5660300002)(64756008)(2616005)(186003)(1076003)(26005)(6512007)(6506007)(2906002)(86362001)(558084003)(38070700005)(122000001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?v98rlifSgPewHqcXhF9bsTiGmiyl6oyM5+eqCL8ZSA9ezlf0khT1ldVk67?=
 =?iso-8859-1?Q?yFw2perosEZtAmtyAJnG6HrEqtOIk20WEsRa7o8ppaOuLzlqQy8wGyhvOw?=
 =?iso-8859-1?Q?jqrVpHtB+sZMr5+OGWXsnTrtFzs/cFEq+PP73A+Be9e743vuJXCHFVRVEo?=
 =?iso-8859-1?Q?nV5gInbx4UGLpxTLnhpyzw3f6KIg+CbXspKeumbp7bThAmwc1uu5Rw8QBn?=
 =?iso-8859-1?Q?n/OvqpWpDPWpMMmpScVBAvjVxLM0kjbbyhvkWfaRrCLBJJFVysSq5gBdsA?=
 =?iso-8859-1?Q?QfHO6f9Azvbh48LU1Q7ROtSkK9aLHb8hc9BsueD7hJl/8/XvGWZGg0XMb5?=
 =?iso-8859-1?Q?cuRhETklFivkUgQnl4u9MrwbJuSuV5WSkqi6uB69Ydbhjqh/qUKyrY8CpC?=
 =?iso-8859-1?Q?ir8NsMlWTaq6T4kZ/vvRuy4LxmgGusaXUWgbkms6EijziqPg5k4JFz+Kfr?=
 =?iso-8859-1?Q?nNVSQeAbsOOOsJKg6F/slU/leT5l36OEhmt932QNf7T2SXvumbqRfP8E19?=
 =?iso-8859-1?Q?B5Bsot7d40w/Qnb4VzE+GNDkiqqfKrhjF/jEPQlJwnn/kzkNZTEwdVWMmM?=
 =?iso-8859-1?Q?5iDuddEuR/gA9ozmimlulmhQ7hUqp58HPuVIXHtZtyIr/+Tv5EVEudyfh0?=
 =?iso-8859-1?Q?xz4Z7cLsWkj8DcocDlsC9NxCMitzJJ+oQ6DVd+QWnSSZz85PIyMO64UTTt?=
 =?iso-8859-1?Q?693X1tQsCkcgVDbNbxN7SOOnThgUggMJ/u0WJfbRQyrLxwVtF8qSHzP0Tu?=
 =?iso-8859-1?Q?uJEJtqYanNMP0F6KNYc0oN65mH3CAuUcL/mh56c7Cggq0+yuZQGZv4q/E4?=
 =?iso-8859-1?Q?5nnY7KQH3eyemNttftrCnTPKIQ2RxbyKr5XeakOfR9oAgzfKC7AyzeONUT?=
 =?iso-8859-1?Q?be4eIq/8ISWcNuL9sqAw91sY92H0eOrWlNsV6GRh6wlT/+AYfdxs5sHwRc?=
 =?iso-8859-1?Q?3qV8Bhs13IpG4je9tc0ZyY72Yx6UDKpfw41qFCL3ot83VfAEkeEX6bl7Mx?=
 =?iso-8859-1?Q?J3yw9eQ6SAQxUd1buKbSaClPSHs/Ctx8IfV78GlmvDLiMkk6/P0ie8ErHy?=
 =?iso-8859-1?Q?coq5UXXULcrKvE79KvmEgFRYfma90mH2EzV/sGPGVo0vPxZ9L+hQw2pYIQ?=
 =?iso-8859-1?Q?YKZKdK1+b2yXBbVwO+40u3oOe93if47RsWqzPgpW7DOiR3V6OIu6l9xKl5?=
 =?iso-8859-1?Q?D26FBjnaytd0OlEgV+fo1OTnqFaGbjZ17gdGSti/pC8FZlSxjrTB7NyTBD?=
 =?iso-8859-1?Q?NPmp2yiJu1/KsfIn3YMg8gV5usgM/yZlnxF7zJPeWgCCajKf7MuAYX//lq?=
 =?iso-8859-1?Q?eXZlCHn5b0NoemHqrJZVNuvDwKFofcjAfK6ivKz//8iBX16mSH6PZlIxgx?=
 =?iso-8859-1?Q?/HUZdmhyFYiX7C7BFxLndBu/oE+c9fyWqYqpXmxOyWmEkamrXjrG7InFG7?=
 =?iso-8859-1?Q?PQXx6WcJlE931Sh0cCl61vvtzpmCOmZRJisnu1WIgwY/XMtwDKvYY1o9n/?=
 =?iso-8859-1?Q?IG/bfqj8t0WCciRWQcfVDpeoSyEDZUWlyU9yStR/cgjcGMisGe4lrDEJF/?=
 =?iso-8859-1?Q?Q3n8iXbOQYOV00+I5FCH2+jAb0qwh+AkjP80FyV3q8wIgEuRC5K4vvqjM5?=
 =?iso-8859-1?Q?ou0EWr5u9tcdSSHjN/nS4Ss/5Xzxx+JBug4UPCYO/ESzzthtoTPLMBkfcA?=
 =?iso-8859-1?Q?7HWTwPAmapFNkW4RAZJCqOYUch6GdDX/bfUKa4sqONt//tnOtpzIQ3Tf0g?=
 =?iso-8859-1?Q?Jp+M79/CEaFRFWdC21mFeqg/sUksJkV7c0sX5eYkeW4pWFyxb8faELzX5i?=
 =?iso-8859-1?Q?4ALtnAz9PeBhpZ5N/hHp6eeYT9GKZpo=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e43a0b3-16fe-4786-efb9-08da2d64b8ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 00:26:24.8745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Grnv5MA+E4e0rRJU8KBjX4DuCnDiJnNfb2LBRFXB9RJmm+ZqCIi44zq2N5aq6TjlzShgCv8oRDSRmMuXBJF5Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3081
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=694 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205040000
X-Proofpoint-ORIG-GUID: tkLT6IBb7sdqRIwpCRiNQn_wMldUZC2F
X-Proofpoint-GUID: tkLT6IBb7sdqRIwpCRiNQn_wMldUZC2F
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mips uses mt_init internally.  Move this out of the way for the maple
tree.

Liam R. Howlett (1):
  mips: rename mt_init to mips_mt_init

 arch/mips/kernel/mips-mt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--=20
2.35.1
