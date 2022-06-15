Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623BA54CB1C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 16:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347958AbiFOOUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 10:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245182AbiFOOT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 10:19:57 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5584506C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 07:19:51 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25FDrsVx015214;
        Wed, 15 Jun 2022 14:19:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=gX1hXPuRmRG9uD4uV8G5RZNXTlWniom2HjbDN8MHq60=;
 b=HWvrJ3fjm1Cr0ozgDmzzBnBV7IoASnGl+mBemYNBxFlAa3UO7CByjyRXEtI0dPUgMMSz
 mSiOpzWprDN5hCXLqQl+QHyTNJKS6KDKGdnAugxmbTqhlo8jTSu67/EewheB/LSsWWxz
 eJnFwFenTt1sKq5pm5vex/hliBAy8bRY/FLEW/L6sU8bs5DvlkfmXq5S//XVX9IE2Dt1
 0A2jbotHISxK4sf0YqE7U/3x/3PBEcFgpcELbwWrq8KkpiWKIqBeNCUWqxWRiPTNBfaO
 CbgAe/4wzO7xXgNQvbmRO3L08EIoxuHY2OsxKK6e8U/xFjA/O00f5ggSnHANlMpLJfiN tw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmhn0gsfv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jun 2022 14:19:40 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25FDtnhe031252;
        Wed, 15 Jun 2022 14:19:40 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2049.outbound.protection.outlook.com [104.47.57.49])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gpr7p2nrp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jun 2022 14:19:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eb4NKf8aIZxDzS7SPbD3GaPpd5ho6bIPNT4DnNFC8KKUQWggSo3zNHnYLjvdlox4EzQHa1J2vx/xJSMbPkDhUKE4Elg1F5y5hiO5VA2FgizLjRQb4Xu+x9UVKlFHxdmfOxyFONw3t+R+nQQZcZAgiBgNomfph4/ECNhVu9VMCODiauvDNJARZv/LfDAo0CmRnWeUwEbUzKPPktl2si6rVHNzFPPyab3QZm4gHo8EMKeHXOaAz8j+JjeJVT2s7NzpkGB+JjUerecJUhW5yuGgP6qKmQYcngCDmvNgVkfjsLca/O2lKoAqIZWIT4gqXI8svpX5KP6yRLIaA/fkNvBdeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gX1hXPuRmRG9uD4uV8G5RZNXTlWniom2HjbDN8MHq60=;
 b=R/D4H7CYTr13mViVVKl1O6wr43EXn//BRvzrh9BAYqxa3go/mJB0R5uyr03lU+S4RRjhN8VfwG2khU1QjJvWqJYI2EoU87tepyDv22VeAJzW06NMkfxMSNMRbScGspi0YoCAf2WWZZFDRyJtzNTpNVPl611tiuvX5Su+l5eOWVterNXlpjG3KDBcIWo1BE4DMYYnLrxriH2f4NodN1bdTGXyQdmqL7FFqFuAVc0W7r3aWyExqlxWg6uVwF8DCo7eY+IC7e9vMToFRGKQP7PpufyLVzRAtOvnq2vWVghdqOPlDsni9EFM/B8k9YX55HB+V+t+8I/crgk34mnISrx05Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gX1hXPuRmRG9uD4uV8G5RZNXTlWniom2HjbDN8MHq60=;
 b=jaVZSF6dNrcED73iJiUIIX42hEP833R6VgG9vJXwZcWlCWqI5V2+xnVeaoIsN4fyA/MCKTWibMwux3seQm1ciOD0yU3Ll0hOJSacsVh9CazkYDTbPoBrvjqO9w8zO+jENId7L6hGDxbLn/uQVjXlhgBGlxyL/3kWPNylJjoBXbs=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MN2PR10MB3342.namprd10.prod.outlook.com (2603:10b6:208:12b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15; Wed, 15 Jun
 2022 14:19:38 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e%7]) with mapi id 15.20.5332.013; Wed, 15 Jun 2022
 14:19:38 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Qian Cai <quic_qiancai@quicinc.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH Fix 0/3] Maple tree spanning fixes
Thread-Topic: [PATCH Fix 0/3] Maple tree spanning fixes
Thread-Index: AQHYgMLyoo6n1x1hHkKVRf7SBK+7aA==
Date:   Wed, 15 Jun 2022 14:19:38 +0000
Message-ID: <20220615141921.417598-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e32a7937-0a71-4e22-28ad-08da4eda14bf
x-ms-traffictypediagnostic: MN2PR10MB3342:EE_
x-microsoft-antispam-prvs: <MN2PR10MB33421C9EDC8C8EA17A231AB8FDAD9@MN2PR10MB3342.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S/kDUVvZFZwR5FSC2JV0D3K/VbObMKqLUwrUjPzIK8Sp6Be4ORxHC2H0CI/n3pHDIT7kzfBwDhjHNTp+y2JS82QZjkFHaexj3PkNOyHxpfkR+GWC5DRtPzCyLvLm5qegCEiThZMUUTbjwkmnb4J8DIhwAiBJkBQ4H1saCj3bG6ALGkk0DDfAWd1kP4VXr2McrKfBvBkYruCCoqEfEs48ttucwWqvpupR+RcrlEK29W8HhYawPksmRc0E0rxI+Wmy3rWkrj5wxI5QGaerRKUJB+nEqE2t66P48TVXx1l04s+NjKFnERzYDuQCAdKcNgYV7RrkDY/TxdEGp+Lp8+BS+JP3LsSt3tOtv426Gi3o4jN4c/J6xmRGkdmOZhvl0S8JTTaYyU6MFuJubPyAB0M3TWD0KH/CkBsNFeh70Wbs7tsnKAyDpR5w3L45Be2vrNm6IiRnUA4icthxyf/26ed/IPYQ+85y8YjgJbD0PQzUhlNFL/tQsTllhOSIq5C2Wx77hPdKsd9CZBGjCP/5UU59XsMeAQvWxdVZF8/8zY4S/X7TA3OHCjIicesjUGXMrW0nMlS1qX1/QmCsHwmTCGfpuv9bKeeCqcm2mleorwj5TuxPi8FPQRJ1YdaOABXb89XNPlbns3XYvTyzI3M4SvFdRFCvvAd1trINfNvvTqkqfiAeP/+YQH2Ofclrr//LjlHBka7n9U9DAGoB/asECQv22g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(4744005)(86362001)(316002)(122000001)(110136005)(38100700002)(186003)(5660300002)(4326008)(8936002)(2906002)(71200400001)(38070700005)(66556008)(64756008)(66476007)(8676002)(66446008)(6506007)(76116006)(91956017)(26005)(6512007)(508600001)(83380400001)(6486002)(1076003)(36756003)(44832011)(2616005)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?GidClaTKngrbJXWWz1eCfsN6vTwigsMXoFppyuHsQmlOBMDSnR4ypFTIYn?=
 =?iso-8859-1?Q?Z7K4mZRPIjfDb52shNW0dAu6z6GoNt7Md+SAkKXTPgOoPQDaI5xdjM/iUp?=
 =?iso-8859-1?Q?d9hdUQLfmIgHixd5XbyhxPYbgsRB24AeW8na6voJV78qyzFJ2l2orAa64M?=
 =?iso-8859-1?Q?fhOxks6ZlT7fWVpd1n002cZmAIwpL4Dv95GhsV1RJtet0lMo8Tb9VA8Omk?=
 =?iso-8859-1?Q?y3qeZ2j8pgf1i/4ELuwhdld89RCJvx4CtUuktDIHnhnfz0u/h7Sde9W43n?=
 =?iso-8859-1?Q?lYJNrI3TsGziBIz0Aux+3G3j+Ke9O+lbys0Nqw2GOs3N3tN2Sm/5xapKis?=
 =?iso-8859-1?Q?9AF2zbdUEL5vIkGoS6UfNaPQmJfG+156XgU2wv8GT7ortGWHfWAytZDCWl?=
 =?iso-8859-1?Q?lKdxVxOxHBPwKEtWK1iVfsJ3t1YZMKD8TcIo/Hk8sIeY1BDbNdJ7PpkyoA?=
 =?iso-8859-1?Q?MhJHTKwk/NMJaWiZEWcFaLp37pkLIqLmmfPQnKaIFgfaMgmTAN+yOB0xFA?=
 =?iso-8859-1?Q?P+7hXFvr1yjX2CQW4FSQnK1vBMqYrGCb70jIwoSPfNqQNJNXqCjv+oU6iu?=
 =?iso-8859-1?Q?zJLXI85KILyI2yRWJfg3aKiVfKclCUoRcYsu79GtvqZxGoKoKRjwXHhLdg?=
 =?iso-8859-1?Q?P9KEJMQ2bKhgNXrSxIweEKXiTD34HPQ9Tsj/g6Z0BdFm3bRJLfl17O10aX?=
 =?iso-8859-1?Q?wC+sbRvGBgzxrg4eSnjG/f7jAgiK3qHjvmh8UC8YrwwCTx0E1I9JdGxHpl?=
 =?iso-8859-1?Q?+IwhNK/5IFWU7HZDlJkZaJZOVJ+tCBecLhZgrDwe6Z+84cRjc5vTKSeaEv?=
 =?iso-8859-1?Q?C/rzH+NM+PUfpFibEk8ajPoLAXiJkr1HOTEmYoYPIkZeGQqEKD/KIM+M0c?=
 =?iso-8859-1?Q?nUc+k0wA2MaGQdxQGpSFhstJE9KG91jeJy/TM972vWEDMCE4y3XMcjedKa?=
 =?iso-8859-1?Q?iQCS1IZRErEanqs8IMxZ+bMMLAq0T+vwPl4Jg1BypPL97Xf7jDCVzGepWo?=
 =?iso-8859-1?Q?BeRipmZmODiNXGZv6nTglba7ULeqVmxBWAKfAVh82v8YHpbmr5harP0BMw?=
 =?iso-8859-1?Q?YYdWha7Q/2W9kapD14M+y59Sb+ccwk3ZHYzMIGcqNC6g6f1rGoDdKeWyyL?=
 =?iso-8859-1?Q?9OVTL9PRW4K4+O7zrlnhbsQd3fFDbZX6vbmXzqUBxTdC3X5bomN8HH7J8G?=
 =?iso-8859-1?Q?UoDqbmLolgXKROeWYD+N2CgaI6GJuyOQBSGGLLpITYzGiNB/7uRdvGBksj?=
 =?iso-8859-1?Q?vt/3EQxS/A9TzYvSkDpX8U+O8IyXmVVsFq/QP3au+EHkAYL1shpOSpRO+x?=
 =?iso-8859-1?Q?1+QzsfTo0jZNHfOlpVmSsAcSrNtTraqBG7O5zcuAu1xgVnzZuIpYnNx8QF?=
 =?iso-8859-1?Q?A62EUHe787ANVCkFVOVr9aecHAlyglXkW9jLd7KnHP12ENsZZIMhTWtbJ1?=
 =?iso-8859-1?Q?8cojnNkqXti4dZTwIayqp5b9ATkAbR8+Riku239+SvHuqmFj19QEN/LFRN?=
 =?iso-8859-1?Q?vvxqSmSHJ5I2OhJrYOBWjRBfsNX6r/TvR0vZDKUXMVqhvFgDZu8LHDqPMb?=
 =?iso-8859-1?Q?cFen3Xek4mKQJ55XkNcTTtsRGuVoT0KbXlEREQr/zWeMFtwiVmxVmaDSkS?=
 =?iso-8859-1?Q?QNvgc2AmKY0vcA6wV836wN+7CYvS6xCSB8BhlJXVvsDJbyu4KHJKx7IkIk?=
 =?iso-8859-1?Q?T+piw+tZTlwIiwMZ32o4DMreOe2vENhsqbtX4OL8PVrR04/s9zwEhd9ReG?=
 =?iso-8859-1?Q?+T6ZIsyMMBuHLTAG61UI5fvZtXBkZeVLgUhaSV8nGqA0mxZ/rlpov0FiSr?=
 =?iso-8859-1?Q?2pP2akB9cxQEGlcZA9xdR4qZkc1gWvw=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e32a7937-0a71-4e22-28ad-08da4eda14bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2022 14:19:38.3630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B39EYc3Xna8Mgn14cNnS3q/E/664WC2Hjq/Y+yj7bBfdf58ojSFFiH2h/DqOLjd5nTx+vxh77YDzjT4dn1tiUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3342
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-15_04:2022-06-15,2022-06-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 adultscore=0 suspectscore=0 mlxlogscore=815 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206150056
X-Proofpoint-GUID: WFArCfaUBHqnzsNsZrEneivUhpK57IMG
X-Proofpoint-ORIG-GUID: WFArCfaUBHqnzsNsZrEneivUhpK57IMG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Please apply these to the maple tree series.  The first two should be
applied after 0f3ee6b87b "maple_tree: cleanup for checkpatch" and the
last patch should go after 17c9912bc09d "test_maple_tree: add null
expansion tests".

Thanks,
Liam

Liam R. Howlett (3):
  maple_tree: Fix mt_destroy_walk() on full non-leaf non-alloc nodes
  maple_tree: Change spanning store to work on larger trees
  test_maple_tree: Add tests for preallocations and large spanning
    writes

 lib/maple_tree.c      | 315 +++++++++++++++++++++++++++---------------
 lib/test_maple_tree.c | 277 +++++++++++++++++++++++++++++++++++++
 2 files changed, 480 insertions(+), 112 deletions(-)

--=20
2.35.1
