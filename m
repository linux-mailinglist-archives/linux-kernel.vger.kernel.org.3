Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6817571D62
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 16:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbiGLOyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 10:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233803AbiGLOyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 10:54:09 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0A618E0A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 07:54:08 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26CCtaO2016693;
        Tue, 12 Jul 2022 14:54:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=CFz8liIYcWEzU05dtNJBl/R3bpiin88VXxvajT5ThE0=;
 b=IhT6CKjbyqS9mHmmHc3ylN79+PcKFXNjnDRGz6tnNrSAmnQ3ECT4ruLbE72MRTM8p+RP
 k0abWrdkibjfzjIXuOKi668SiGFaQg5FyBZHdnJT+lfd6iGM79JrWMkH7InXyOP05Igr
 rMshKczpQMJaOeskIUMuoU5HeTRAAgen9xaaMthTLuz+mvbusbcJEkRD9fx2vyR8hq8w
 Tnx5DGPMJxAIqWnKjuN7aMtbQlk3weCgM3U/RoqZynQ9eIR48HOMTZzjHIOxu+HRHqIt
 AgRT+0eQRHoR/7bBst9TPiNQfvIBZAXcgvJqj19IGCC85R7Kscq4TvIZ+u5hbLz7eZpP Dg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71sgpt3c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 14:53:58 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26CEoCpw029114;
        Tue, 12 Jul 2022 14:53:52 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h7043t0t6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 14:53:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3mAldrKJlzjQhROPWaOa+9UfVo6Mcqx6HKsIPkmoeszeN0NZpI+fzXxzOrkXD3+TIpl/yj2rxRsyE1BDP41YnN2LAZhBPYzwTdZfv9NGc+3eRy44QUZ+2xPAKSFQBFh3z84nuBmF8SmTgFcaF8Fy9eQTVTMsY5Yv+4QD1C50cLu0CIjsBk3t/sYcQyPS15zcnvD0NNgyJHUCzquAVq3k0U4oIPOD0rwSR/8rQq+WwTFuJ4jObWSMHsCKW87kda9cAki72Zx/alsxE5Wpiq/JxM82iXeuTl+Z3gGnyw5twEkij8aDxy6MBIUp3CG8pOb4hdjV8LA3UcBwjIDD0jkCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CFz8liIYcWEzU05dtNJBl/R3bpiin88VXxvajT5ThE0=;
 b=H8iIpQU2BBC1+SPYDXRmf4umk9u7UUrVLdRLojL6sX5iicsKkzvbVSMrlsFX/1lFQmodzjL2kB55fJa+rQXpNENxnwP5CWsrsQV898Stk22gQoSiNDos1WvxBuJrB0sBAqdlz1+UD4nKydWk7ce/Pt9Q+LFNuMqvBoZGrfMDjIWjXpI6G6a4DWVyY7zrzw/Wmeh12Vox2SjCy7dXhKVYPVtO/MlI89bz5jKEcF/QtY2HhgWYNjSAojiJwk3m/fVv0+XzFUiKUxM7K4OgDBjCEzgU5cn67lWEWNoNXAwn74wxR7hq/qjcHfC6kEyP+RRVXO4lf56d4aCzVwZ9BGlPSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFz8liIYcWEzU05dtNJBl/R3bpiin88VXxvajT5ThE0=;
 b=smkx/iQoW2811LamdW0pK1/vSjRzpdObxNLuGB3D4iTy+3YrP21prISC/KoRkaP+4N+ZAPimRDNikdKVD/Um2DoU/jb/ICwwkKjUsDEFb3CwzM1ARwFDBpz7w0fBlEza3Pig26GjfLSfR/byLSzffWEv2lmpvKe4RUnTBo1HXVQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BN6PR10MB1427.namprd10.prod.outlook.com (2603:10b6:404:46::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Tue, 12 Jul
 2022 14:53:50 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 14:53:50 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH Fix] maple_tree: Use metadata for mas_dead_leaves() walk
Thread-Topic: [PATCH Fix] maple_tree: Use metadata for mas_dead_leaves() walk
Thread-Index: AQHYlf8yENHdxXlZ40ahl3ktlIk6fA==
Date:   Tue, 12 Jul 2022 14:53:50 +0000
Message-ID: <20220712145342.4191649-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b3addd00-c9b6-4877-0ed9-08da641654ee
x-ms-traffictypediagnostic: BN6PR10MB1427:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: axErstch6SV1hdDeI8n/omK5EAQvDeFEs+UUiZ1Ix90r6Ym2UtyGnMGJxUPPOGyN5sla9vvAcXEuEGLxQeAzripdPZBzg4kPEVx8r79XQqMmf2fzjf2XT7fImZpwdRDQ91Y93Ep/PmOXBPkmceSpYAthOONlJEPoDN5iKliHiof+rW0foe7uA72phAXIZ+ITwMM9/5kCXJS/x1nRVw4YnjE+b6DK5AEwg//++0wnH3Zx1QWBblVFZQC1oLmKPrMW98SRL+MjYw+qBjakufqedoTU31wvFh7fI4Nmbkh7B99OYwZ8zsvQI8xE03OCGyYZRM4LeOtkzucJFYlNT40PzW91hBSLz7GrzylAbA70ItWbtTw9XdnTqVyeP1WYPngVh9PnUgS4yh/Pbe28hJBFqBnAQlCB/3/w3Ig6vMPtEkzO7j5uxRuuSjGoP3uFSvmkto0z11Q8gS3lN0/ZUkna0ayDPSPc9nwKa9MQBLdmjJZTLXd8UpkEmCRTGnqexspVxa13acT12StkXAudTOukrCBO2X0RO9l/xYl4rqa9QJHvHP8lFuhMdufTqwrye06u21F26/mP6m4+o0XIWCQ0upw7gz07E/DiMj0MX9AUP6Zi5OI9VcXFbC6sqfzG24Jlp0eCk1rwCOuIEK/raE75KpMSI2dYj+NF4SNhqnv2+IYv0gVatrOqTM6DKoxTOQAoHHeGRNyuZZgzJucjAwmhM7uJBJiHT6snxBFBziITPPLl3xXp7CGRNWIk0MQEfDwjIlXy33hlYewlmGvGuDTy9MOGYMgouEscwM8uWrP08YkpZBA0ElCfCSref4RyhVEg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(136003)(346002)(396003)(39860400002)(5660300002)(8936002)(86362001)(478600001)(6506007)(2616005)(1076003)(83380400001)(6486002)(6512007)(26005)(2906002)(41300700001)(186003)(8676002)(122000001)(36756003)(66476007)(66556008)(76116006)(66446008)(64756008)(110136005)(38100700002)(91956017)(66946007)(38070700005)(316002)(71200400001)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?MrfdIyeIO1Oqo2CWG3W1hM/Tk4hClJ3NdgqlopmitvRuu29Z6YHkBDiMzD?=
 =?iso-8859-1?Q?L/n4+4rdCP8sJnLYoo/l4N32ePdu3BSUtT/n5Urbd6T8jfuUwzfm0SXHVa?=
 =?iso-8859-1?Q?SlIljUTAoTh1cxl6MsUEoXktu3JRwEISklfjm2OWWtkUjEvobLL+6OErH+?=
 =?iso-8859-1?Q?Wgi2s/DXiVU7iETxF6KGG46yTHRVUmrALhwuxBewq/jKVF14pPhkKfjwQM?=
 =?iso-8859-1?Q?JtDba9aCVbgDxT/gxYe7g9CNoGaUXjPaW+ZzztAHD4Hzf+wt8YBL/stnJ8?=
 =?iso-8859-1?Q?RDCauz5wABi8WK9bIm3jCnOlAMrgrnXmPkFTwRC9ndPfncmmwiqaoY+4sy?=
 =?iso-8859-1?Q?SRJrhnAQVX+Wh6zZvL/ACKM0PC5+9QxpeM5KtrABqjAYB14o5G4E1RzE2k?=
 =?iso-8859-1?Q?+kkYvsFiD3epglNHPU0RDfrbPwAdXGpMzWRUbhqME2aGeTzzhXG89juwNx?=
 =?iso-8859-1?Q?bNlFkTwrW7SLIAL2hUTDmLTp3H5FVwJqVFwNZsxR5hfEAYvMGqu3HPrLKK?=
 =?iso-8859-1?Q?eRBvHcp0iSUi1olP/N8W5rIaAVapneVvVbdvfh8H+kuJ1ghW5nDQIw56DJ?=
 =?iso-8859-1?Q?m+XY5j+K/OwxK+StdAiqGlt4X0910G6KfgQLd6FaN6/zqB0nNn5GDEtHSa?=
 =?iso-8859-1?Q?/6NW2CIeQkVt+2zZ0azolBY/cJKF/7STmA1skwuoXrn1tBa7M5Y9orURQC?=
 =?iso-8859-1?Q?RVxzIg39MnxAh3wW+0wBPDy5lPwgkHjXxCU1RFZQlMXXI8c4DzgTwkbyK6?=
 =?iso-8859-1?Q?uccXR98ssk3Eqkn1uo9ygrfimTli07fb2T12/5ca7T+q98/5c2u375KPOs?=
 =?iso-8859-1?Q?TptpXGIM0wVYVmwRh0p8SkRWdq0P+DzrDdEYa8MosIJwmEMFspWZLlhHwv?=
 =?iso-8859-1?Q?n/edOP58MkJqJ2LGq9dE0vCoVL/cWNsFjrdHNYqwJ04OVX14DssHJNgTpT?=
 =?iso-8859-1?Q?2O7SQmMMI1Tr4af6wfJ/66IhPZdWe2zAHgrJ0SSpenDdTkXxtjR2Sc6wvd?=
 =?iso-8859-1?Q?FkyR2Qt7Lxa/HwoTNg26B72QY/h5WUZtFcgNSKveOZMu+za7XgaFekz30C?=
 =?iso-8859-1?Q?8F9c8M4Jh9YDVTJKjJoQqpK5VAsKl9fKH7iZbcEbppurSe8PcC6hmjIRqP?=
 =?iso-8859-1?Q?OZWuYd1D6IyXWInZyjeqYUOzI3xBUPQDO5eP5x2+NR/lMHLWfW1gOA49SQ?=
 =?iso-8859-1?Q?RMjtqhZA8aRurT7H57iTDA73mEelz6mQmrDB47AadoKufUEa4X2wsVA/dM?=
 =?iso-8859-1?Q?sRYF7dLlBO5ATQNO/xZIJxE9MMhJGuGEVRGYen5GgYKxSBosxi65Ap7RPF?=
 =?iso-8859-1?Q?0vHeEz8kIf96Oi+8n9qFPy7VU5z81pJG2uDBQrerBQyqkdnPV5/x45zO2x?=
 =?iso-8859-1?Q?Hg97fJjSQWW+OfKEOKeeXWTkiOJ0N/TJp9+5bEyxSLjXCEeSEygamUisjV?=
 =?iso-8859-1?Q?M4tc/UgmcIU4kt72YP1IQ3O4yw1KEJUGnunnnELPlQJYbnTotPl8T2PYnb?=
 =?iso-8859-1?Q?RL6LBzkwtsgcosrHY5BX6rgohzJT7VCTromk2tQGynGKF8Z9DY9/L67UC4?=
 =?iso-8859-1?Q?b8JhmHXhSKOCdy9K4/wn9fRJvh+rwoouGtkssMfIl5DWN+HW8qGspSfyxa?=
 =?iso-8859-1?Q?S1IhwypNovuAAKnxc/v+M9fkw4A5WoIVHzey0VE4AWuqyDSKlwpbvctg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3addd00-c9b6-4877-0ed9-08da641654ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2022 14:53:50.2823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O46AWv1XmUkBjObnvAPIQehIH3Cwly5u5WZuj50+3ugruyZ/uKWFzbr1EzyyFvmLyNTRtRhfNxv102me3atC2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1427
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-12_08:2022-07-12,2022-07-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207120058
X-Proofpoint-GUID: CxJoKOzKh0NhXRs8CK-GliteG5oy3wBJ
X-Proofpoint-ORIG-GUID: CxJoKOzKh0NhXRs8CK-GliteG5oy3wBJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When walking the dead leaves, use the nodes metadata for the end of the
node.  This avoids needing to use tricks for BE/LE unions.

Fixes: d0aac5e48048 (Maple Tree: add new data structure)
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 14e9ab14c1da..c661fda37665 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5390,15 +5390,12 @@ unsigned char mas_dead_leaves(struct ma_state *mas,=
 void __rcu **slots)
 	enum maple_type type;
 	void *entry;
 	int offset;
+	unsigned end =3D mas_data_end(mas);
=20
-	for (offset =3D 0; offset < mt_slot_count(mas->node); offset++) {
+	for (offset =3D 0; offset <=3D end; offset++) {
 		entry =3D mas_slot_locked(mas, slots, offset);
 		type =3D mte_node_type(entry);
 		node =3D mte_to_node(entry);
-		/* Use both node and type to catch LE & BE metadata */
-		if (!node || !type)
-			break;
-
 		mte_set_node_dead(entry);
 		smp_wmb(); /* Needed for RCU */
 		node->type =3D type;
--=20
2.35.1
