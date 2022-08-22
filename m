Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4E759C214
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235414AbiHVPDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235877AbiHVPD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:03:26 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE05DB38
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:03:19 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MEkbm0022045;
        Mon, 22 Aug 2022 15:03:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=40Zfz471W6ukNOyhk0Qf2GGR9Z4MieDkOVdFAcoHHpI=;
 b=soPb6tLneVruAbKG54I/IarHghe7nqv11u6NqphPhRyyCA1Skfoa0+Dr8vxQyRXWa2B/
 AMEyjMjzlBvW5l+wVfSNntcsCUAMEfBntRMAEfN90MJNcPCJKKwNdT+VGFv26VE/cFPH
 HnwQM7tpAumwNPDATiw2FldKi4ri+Oi0VnfmWLii4UayJb4F1Ym87UxqsKPSP6z9UvrD
 iMf+su3nz1tHFKv/NmmtDtSi59QcVNfiuu/FuHMeOYIRLb+xQLbx0VHkHz97ZTMDdlIn
 n0x9GkQ4M/YYTw0qMma/1BNeh2Sw/i2ieDgEnch0MbeZFLvkRKzNFJCdTBDGyRdOrSBr cA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4btmg29m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:03:12 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ME4Ofg005191;
        Mon, 22 Aug 2022 15:03:12 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2171.outbound.protection.outlook.com [104.47.73.171])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mn3tuaf-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:03:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SmLLFGG2uwAUW6GrJXEIREGctcHj/T7yMtplEv9DLcaRVNZEMSs5hahOICi3381pJwoTDVJn4IRHrU1un0djFV9w/imMaWmYFiqiHpeqgQmbgTE8oDH0u0HX1DVqc2PIyqdWN0RVRXrHUsYwZ7CGwt5hPXI6Jh6uS3jSMS0djCw3OWOxh0XBVZJGngsat6lgjWpAG6AZxVqKjvSVr7E41EYSAqLhGrcKZJ7P++yhVTLW8rE1sH96ShjcLWDrEgxuwDC4CuwcfH167nwqLnNE/CyXTI7Mp+22wpheqtQ186UJCM4GKtK7WrFykFs1i6dW9vrezxA6wbxStxlcQjHBcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=40Zfz471W6ukNOyhk0Qf2GGR9Z4MieDkOVdFAcoHHpI=;
 b=P59n1q5Oe/fGARyHXc0zbTdEokeA9p5muGYkXC69PGJM0lpiKsQzInZooachQbRMeJedd11VShUfqa/hN+zhGJzlkrfp19sN4AbEqwgxgivKV04kAmqJ8dp12axmH5fOTIjntwvaWPf4Y+mpdg3jMwRUGemDxxyq3XkaUJC206b8W8viFQSevjaO5dkaFlGPCW3RgpuXJR/s2ORM86EXPTrGjtIqva7dby2oolGKT3cAxMaqh6rsdjtisk0GdG1l59FIOSCgQ15J6EzuY2+0Ezzr5MK3uFX/LaywW7Nk50Wn71hdrEmFl4G7DoAdlBlL3qFfPyMeg2Bzk9a2NCOZdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40Zfz471W6ukNOyhk0Qf2GGR9Z4MieDkOVdFAcoHHpI=;
 b=WkvoQOV0usncmFHsymybD6bgeUXmNQgF+cxR3IUULWfFh+D5VV9gPrJ7qA2f/z9A6NDcedG64sOAojj/zaLQ1QiXQPFFdj/ToBIRIZS1qnfUDq/PUq/ShTahPxFxB3Hk81R7q8d7QBxS9UBkiLp9RABmQzaQEmKBwDIyV8Tqe+Y=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BN8PR10MB3506.namprd10.prod.outlook.com (2603:10b6:408:ad::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Mon, 22 Aug
 2022 15:02:55 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 15:02:55 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v13 06/70] radix tree test suite: add lockdep_is_held to
 header
Thread-Topic: [PATCH v13 06/70] radix tree test suite: add lockdep_is_held to
 header
Thread-Index: AQHYtjg1r4nONsy2Pkugy88a5z4POA==
Date:   Mon, 22 Aug 2022 15:02:33 +0000
Message-ID: <20220822150128.1562046-7-Liam.Howlett@oracle.com>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e94dda79-e98f-4fd0-b921-08da844f64a5
x-ms-traffictypediagnostic: BN8PR10MB3506:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r89sCDLEUFkgJCnyQRjyfIu4+pKqKdSmwrfabg8CN0npZVnuZH09TxXlYFLL73tdfQPxqhSD+Zk1VvpeZPArJ2DTGpMvppKc7bmS3SPJxTOOZ8Aie9tft4tFI9ve9qCfaWSl+tDFl24dZw+PbOawqiKEOGXmXoo3PcNM+Fz9Ih//90DsrkYi3m7pCNpgi23ZtUTl6ipa84KYA5MJl9WcS2nuvPFSfDAhXyckqQhQEVyDKUzfoOe8qbnY4RfpAvpZHWNj1b2GxBC0oZBPcES9DATOMUlBt0lGbgYjJJH7Q1ba9LJf6h/gPoHVjmdjIzC3jow+sNQJEyjI6nRpbXUvA4T3IwiM5q+8PfFn9VoOF8LbWfvINL1Y8fxiKAElfu0fhyZ7pLnNfP85pGO5LCpxlQ78+6vnNFioL+czOvHdFoOSQDW2hvKPuVEoRXFZ15NpZarHR2UbBlaV2aR26Az0TYGd3cpSz5SGpOADiNBjcGTcXLfrY0c19tpxNBACWxT7AicPhWaEH+yv5OMuKT0C4njxma6IgK9JBOGWDCKQjf+388MjVUgNS7ZkrdOl3Kw0YyNKWq5VAENCuRSQCkfbwbRbICPtHDL+1IWafS6/ikPutWhZxwtCDeupGx7CVGJAxhcktFXbpuUXCEybc3QcLbiUfHB+92ThKWp3xGYMdsAk7EnhCip+srGQzSFb2fT5LQ9OvGusGewhkvbrPO1lehV3tmFLnJtQGrd97LiOc3CxYSthDQKdvJqY2/J8R9635nK4LM1cK0BA78Xuki5/sQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(39860400002)(396003)(366004)(136003)(38070700005)(83380400001)(38100700002)(66556008)(36756003)(66446008)(122000001)(66476007)(8676002)(4326008)(64756008)(66946007)(76116006)(71200400001)(91956017)(6666004)(8936002)(4744005)(26005)(6512007)(5660300002)(44832011)(6506007)(478600001)(6486002)(316002)(54906003)(110136005)(41300700001)(86362001)(1076003)(186003)(2906002)(2616005)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?1XBrAOiqf3o7JkVV7NGpU9mfJjfoQ4tqSS7sfSnxORmRo0bCdHNA1oqqNc?=
 =?iso-8859-1?Q?OVWvlDRh5LtsJ8FS+e1r7OXFCsplalWelJ0ldWmH+PXAKFWtnzagu/1JMR?=
 =?iso-8859-1?Q?2N27RWvS2hly0Us/6k1JEfkfR6vYFlEaXMDJV5T6HzOFB1xs6R4xAZurou?=
 =?iso-8859-1?Q?gdLv8A4ojs3lTqNkkic/n5SmCX9W28eml0+T0xO6gaF6W9j1xvw64E/pcc?=
 =?iso-8859-1?Q?FtOqgJ4AfwPAEqd8C+KboJuxrp9GK3J009rmjsdsGsFwQl3gQFO7/ciCsR?=
 =?iso-8859-1?Q?VzUUNdd+eJm89Gx5wrBeD8StHgq84O5oCu4qLrHKtb5wafa7wNw38W/VWR?=
 =?iso-8859-1?Q?DjCWz84LADToJaJnYLacmUmoas39PNTBU7MON0BFQaOx5i/j5qLrjrZDqg?=
 =?iso-8859-1?Q?Gu12kyeOSB49NXuv8a69beOmRC2U3PU33lq1pL0JH0lzYmTjGRTdf4fxV5?=
 =?iso-8859-1?Q?BAq+OGO4XBskdoXUZTdE7Di+raJfWE+Wfx7rwKvFwI+Rjqd9nGdRd0wGzz?=
 =?iso-8859-1?Q?KpvsnkvUSd3Utuy4FDrEWEmarDa5Lks2g5HNld/I2XaONCacaF2Xg2+cEL?=
 =?iso-8859-1?Q?IPjUvrhWpkcqhTFrc201z9PiA1Iyb2X/FvTJyvhfyrhb/XDd53WueB80LZ?=
 =?iso-8859-1?Q?EylFBbfYGZXvTXTazQsbA7PKhW2tBb8iSmiUkpCYjhVtsLZA55uyj6rBPD?=
 =?iso-8859-1?Q?gtwrvt1YS+qcqbaegaT5FPDSQHiLr4/FABsH1cA2qn/OSxDunkN19O8MDc?=
 =?iso-8859-1?Q?iNnZQFRodxffcMHpTJSQAY4Vtl+3Ay4FceMpDgLPd+7J+v6b8uiXnvV0jT?=
 =?iso-8859-1?Q?s5El+dNyyzKGODPvUERsM4ZTIRLVzyh+P7r6K/Ty3QL/GmMU4nn5ozolAv?=
 =?iso-8859-1?Q?KsoJglcHCFfAoZuQqxvuC8598EKk6NikdZw47HuE1W0EiCww56t6glzlLy?=
 =?iso-8859-1?Q?XSY7s2CLptviE7Um5BNFiYi+w3DEkA+qhCRMbdtVSEu6KVF5ayKVOl0/kH?=
 =?iso-8859-1?Q?jJBSScr4e5wO1vObbCEY84ej3Qz4lwKLVAtQCMPqM1IEKh69UESgRxmP9C?=
 =?iso-8859-1?Q?yjYPqU679aAyShYMkdb/dhORCHqyNMVw1yNw/2NJHYlTMEObVasfIAfCsl?=
 =?iso-8859-1?Q?RGZGXm2AnQzebfFfqXOPGVkNTQ1aYoGuPM+BZEYHEgXiBOxHjwWpWc95Xx?=
 =?iso-8859-1?Q?9V9stIKsEuXe5ZTpllci+VwWqtj879LBXVUIPh07Wc6eRCaTWcFni86FWI?=
 =?iso-8859-1?Q?2fdCx5aXCEIQQ4Xlpj8rk3/0ebCThRsWYUtML9ybYtUKJpLd/j0j414du+?=
 =?iso-8859-1?Q?WyjNSOC/Q1NIEDFhgxFsRuw9gAdhTy9+fjTwQVkgrxc0qPoy94eIoHXIpG?=
 =?iso-8859-1?Q?oMVPsmSidGQIn1l3Npam5J9yJbeCLQ6VqRqaK0WJUVnDcAwfvyeV/1LD/N?=
 =?iso-8859-1?Q?nm1J0u1Dpn/wj4HKs5AUMyRl9U7Aq3LNRRIcMuEYwXJoNtE8CWOybJcmpP?=
 =?iso-8859-1?Q?rUCEQtPFCzXs+a0ugNO0LDk3Ctrna9cYNJn1NO+OvbJJ7Ly5lwkQJNQ3js?=
 =?iso-8859-1?Q?zae6o/w8p9PVUSS5YKfmoEEMQMB2Zc2js2rUHUMXBVloX0MtH/nJAdwUFz?=
 =?iso-8859-1?Q?FA/qdpIXHv3qtdCbHIwK81F8oYuajv3kUO+sxJSq2/84iDeYylbYz3uA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e94dda79-e98f-4fd0-b921-08da844f64a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 15:02:33.5507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ULjXw/Gxi1tg1IDmB2AdL9AsJ4UdcEAepk6tPANsO3Hp9F7C/40kIWdj0DXsL43uBnpELM5CLLLKBneO9CnanA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3506
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 adultscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208220064
X-Proofpoint-GUID: PcnuSr99pQ9ARxIrA3kkl4ppEqEFz5JJ
X-Proofpoint-ORIG-GUID: PcnuSr99pQ9ARxIrA3kkl4ppEqEFz5JJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

maple tree uses lockdep_is_held, so define it as external in the header.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 tools/testing/radix-tree/linux/lockdep.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/radix-tree/linux/lockdep.h b/tools/testing/radix=
-tree/linux/lockdep.h
index 016cff473cfc..62473ab57f99 100644
--- a/tools/testing/radix-tree/linux/lockdep.h
+++ b/tools/testing/radix-tree/linux/lockdep.h
@@ -11,4 +11,6 @@ static inline void lockdep_set_class(spinlock_t *lock,
 					struct lock_class_key *key)
 {
 }
+
+extern int lockdep_is_held(const void *);
 #endif /* _LINUX_LOCKDEP_H */
--=20
2.35.1
