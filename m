Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D025AF512
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbiIFTxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiIFTuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:50:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6414380019
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:49:59 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286IdAfb020044;
        Tue, 6 Sep 2022 19:49:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=7dVZ36W2B9PDvrNTLWh30F+7mrKEEJuPG6HKtfsJpKo=;
 b=Qlrsqbog8VKbAeFYDR4gmtVYagzKXsC7jCjq7myVTIxi5k2EPO80qLmdbIvnZggFJK8e
 GIb9aQ8c5VUBCPSrrm9JtYIuymV2jvyi4whS8T4iGzc0yNpNukl3rWRNEE5Id7/xgAL6
 tEK10EtonPH/DfxUhIWOJsaROaloumDi6Xa3o1OG41zGM+ogPRazLy1V49I8moa5Evx4
 J6m3SbEr6xcyXQb1DXjjWk0LsJf/FthFm5LCZQ0u0ag/BQy8Aq/LM6/40Oeg7DZKNaYo
 gQS6pwVRzXzJStaUqPcV2wgyQX+m1EAQm3cIcatfhqlmsQydGlj/c9iMLh3DWgQJWk5G rQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwh1exns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:51 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286HF67U031251;
        Tue, 6 Sep 2022 19:49:50 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc3ahkd-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Htm6gv3p8na8C2eJtp74wUfY3bft/WkIgKYXX1k0I26SbRSe1OFyWcJNXAY/M/qDauqwWczBpysogx21VBRqieRZp1FEXAIocYosFiw+BBdFMWrMTncl4Qpu9+IfJwC8tX/Onk1hlh27PL9Vw+0BfIzbK5LmWpIur6EMv97fyRA4OXmUJMQ1nz//Y8/gQTwn22rC6YuGYMj2sljs/RsdkkFnGiMJJoC2rvrFTC7XGD3GUPca2PVQyyr22H+Xsl/9H30k2bYC7iLLik3DXDntGxniorfEA1pm/+f6ijmCxXdIR3NQVoMyJHJNxifHDbiO9/o8DFUgN60hSq5tVtMbzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7dVZ36W2B9PDvrNTLWh30F+7mrKEEJuPG6HKtfsJpKo=;
 b=md6yXl4DnqFyPptInROWtOjHJdTPjgZKwuyVqDMIYa0Mb3rVagEOpGal8Xy9SMjJOT1OR09Hhe5omTNnTwbMY3VWkciKkaUwh4wPTVXyGqY/9vJj/qJC7X6kH+MDH21ypW9wEuBDrWgPz1NTt72t1WtD46Ok5YH6/Gn2chll0SFC8qyI+BGDCv0RpRo5DLbpVlDisDUt526MCXRxz+LKtlVQHpkd7WjFHVK4VXPs+xsV1L37omf7tHNPY3KQHJwjGRXi14OoHo6Bc94jv60YF7luadLjW8IJAHai5LyjnPGX+iRsZnm5RmQpeSDCC3fCSAG2QsbZILadvLW9fcJs6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7dVZ36W2B9PDvrNTLWh30F+7mrKEEJuPG6HKtfsJpKo=;
 b=KmswoKE5YGgt49GG2eWuETScPkAEEDGxkv0AZcXKoHcdU2xfljiQ+XomrRttJWFDmP7FnBbuoaOBrjl6RE4Wvg6g+DPSmV4skWNNbxkdEQkUuNbh7D1JFp9Y2rsMDqFNJlTmCpn7m4AElCoOuXLgs1QcEQFrAiLKmoek+gJgzJA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB4876.namprd10.prod.outlook.com (2603:10b6:610:c9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.15; Tue, 6 Sep
 2022 19:49:47 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223%5]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 19:49:47 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v14 55/70] mm/memcontrol: stop using mm->highest_vm_end
Thread-Topic: [PATCH v14 55/70] mm/memcontrol: stop using mm->highest_vm_end
Thread-Index: AQHYwim2cMVZ1COXTUOVia1g90FxOw==
Date:   Tue, 6 Sep 2022 19:49:01 +0000
Message-ID: <20220906194824.2110408-56-Liam.Howlett@oracle.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e504a16f-73b9-4c95-5313-08da9040f465
x-ms-traffictypediagnostic: CH0PR10MB4876:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1dGuaU8GIR7HhE3EXwb9+UYuzinj5vwWUbFOeHwgFQt/g2DqPSN1PLWhK0hFTJElBPv8j8dhWhBjq8SKb5V72ub7bg78nwfQWeLtWnJ+z3afkaQQZ6gMkQV6pqDnb5iVgfQi+LEQ7o6lADwvEhZxrRn/vrnELA3/X4NngschNIM6Hls5Ztf3XYfyTaVIWS7kqgP81RjM5Q9A1Lx2G0aSO/6oQaPbZMLP2zT47W70JzstWI7zDD8JpeNfRSd4OLlBl5m+rXK2Bd++x5kHhJieKj8dwivY1nbqV4j3miIKK9BfMWs2ki+WR2wBnjldHAAExIrSJEq+XMAw02PCMAlxFnqx/rUbhYsz4fb1mGXEvYkygfmXk5ijv2kqpANLL56dUCcxWJbWKqbH9M9psQKZOU5Gfwc9S0VonshjGHlH0NNVsh8Zfd8kZ2nnlNCW81xzQooUfyXF0CuX4nr+siW/H6q+fVb6LEg3blIb9czT9oq4cuao6SYKPUPdDhYljdvI/pAk36ne9j+vHITyuV0JJJenqhJM+apS7ewJNNmC3LiZgSR+kvaxuOyjT2pkSxHE9lZ5DC1xHNkgxKEqxOZal+gZPZCc+A+kwQV8xnin3OnITg2OZlxHliZTDrxnqCasj8y/ZAod2LYg1uIF93gsbJN3Sf3tCcgouywKVjwwzZo86L0iACBZ0J7/jFJ1OkoZc1AMdiYXBQnZhR6dLtCGAH+vT6hbG75+izdnf5sJKg1Qbgv+0tSxCjHfClCoUt8CGZdNATtweN+KebiXy/BPBQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(366004)(376002)(396003)(346002)(8936002)(6486002)(8676002)(4326008)(91956017)(122000001)(66946007)(66446008)(186003)(66476007)(76116006)(64756008)(66556008)(2616005)(38100700002)(38070700005)(478600001)(83380400001)(36756003)(1076003)(5660300002)(41300700001)(71200400001)(6666004)(44832011)(26005)(6506007)(316002)(86362001)(107886003)(2906002)(110136005)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?4DyU9frA4w8whxCu34gj9pvw5jP79sNJYgSxrftH7SPxo+dIMqIu/VpJK1?=
 =?iso-8859-1?Q?zQ5Dv0W46I6Mssj8OBjUruGy8UaIS1DGXIQuM1AxCPVXZAhC0fkzrcgtvT?=
 =?iso-8859-1?Q?ME8uxvl3F2+4TYqgZKht0twMfmU0L8vlIkCaOcFCOEJli6ChLR4abqpuHa?=
 =?iso-8859-1?Q?p7O7isaXlweidSTNE3AN/n9r8Zsnf6C4Qj1UookcirKZJve5EeGBFbLygc?=
 =?iso-8859-1?Q?NkOMfi1Q4pmUjX5a4lE9AZDT48Pzo0xkrSm10ElZJm/cTZLCduSOs6tOMz?=
 =?iso-8859-1?Q?7lj7EdlQLdZHl/9t4pAQ70VL/hCj9SzWXcAk+qeDil/yGlYXbBqJwojo6i?=
 =?iso-8859-1?Q?8B8AHRtAv3TNrdQr/wuseYaqMOFQO3zGmlMsAj/P5PUSWVEj7mDdJuHZt3?=
 =?iso-8859-1?Q?0u86YXIwW5zWlmngxPl1FExPKdbKgpupjBgTC6y0luTRK8A0+d8AX+Vlfp?=
 =?iso-8859-1?Q?cWNPFdEO9gLu3I6HMSeY9gmPluUKA5u+iGdtOUt62lEw1noLlT1Tgo7kOJ?=
 =?iso-8859-1?Q?a7nK/qR9/nFeSYEFKLfc+FbgsJIX2/y5BAl2NvFyucxxSxYnd3EM9mogq9?=
 =?iso-8859-1?Q?Hi1+x+UvEw2l4dnBXCl+cU3I61R8W/KEgr4hJQhZkhEYS+yrqskyWfMyqo?=
 =?iso-8859-1?Q?uOPzAd9lohwHwOprWwKCRIPnAwIE7CYl/2/6BfaCVjJwBp0bcK/TX3HNL6?=
 =?iso-8859-1?Q?QUNO3DSFvb5iFl8jgp35cF5H8YGA1fNE+5bSPNytdaFLMljYNGktSORi5k?=
 =?iso-8859-1?Q?3SmZJcSxFPEuTi2cd9vXMbNt/jswpEK3EDNHrmrp53SicJ+pV0JnZ1FJQ2?=
 =?iso-8859-1?Q?zEzhzh5q0yJEOu5jEv2GEIUy3Sp9q/vXTTSWSZh4ODrhPykx11ZADbbpfX?=
 =?iso-8859-1?Q?JRHEsqRRyLxZmnyEYBbMlxq33AESoAYDvwbAZyq1LKFpmWA/ysOB84TuFI?=
 =?iso-8859-1?Q?V1ujDV+rD9IiikNqnXuHa7+O1Dipq1l+WqnQQJRWsznk7o/7T/V8ysL3DU?=
 =?iso-8859-1?Q?Yo/mnuTWXOPQVsX1QsNU0g0y3M89TOCUcXxulmmr60vX9dRGOHYJv5ZWnt?=
 =?iso-8859-1?Q?F1JtNc0CkR7VWmW7XBODOI7zzw/z6l8HJ39lAC/OFi0Jn/MtIouDJCw1uQ?=
 =?iso-8859-1?Q?NIECmURj5sLxGHM2j0ucu7HzaYlxbb7jkrv0pFcN5FfaEkt0crfChSrOcB?=
 =?iso-8859-1?Q?I7WDK3wwbee+bih/T2vbi3v/LRyOV0zZVeaCQRTU+ErHmKAzhLlmhBoEIX?=
 =?iso-8859-1?Q?DttQmXFm3g5LJRVUw6dsyaUPL77g76sqkO8jCqcLIRk4bSRmSkBoLBVoJV?=
 =?iso-8859-1?Q?S+3vlCz/CTerw7XEg7DN7AZ6S/n1pcgc+2KXhj8v+iC7Dh1NJkXmRNEQ0M?=
 =?iso-8859-1?Q?jpjFoUceM2UKJpQx1xPjJIJnd8RzRSVho+bSzw/EcfDaMtzxCEJ1HrLF7a?=
 =?iso-8859-1?Q?dqXYfam+gzsydZ3T0MzKOPOmvrBOMjKp7iHu/vDPAff+6zekV5dT//6/xa?=
 =?iso-8859-1?Q?PEsFmDioGtB/ZfjnhOC9pU75mqgIonMviYxVVnrOINEKKPQjBAtrf5nLsD?=
 =?iso-8859-1?Q?TkPdlZa7b3WrEqhMWCV4e7uTwnE9N0eZcxufuhG6V18VUSX2WhJuBeYs6C?=
 =?iso-8859-1?Q?ZjkCEoXsboh5E4W82b+5JyvPj3q0s6Y7hcRBZlLnBLL/Zi7Tw78f6lnA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e504a16f-73b9-4c95-5313-08da9040f465
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 19:49:01.7715
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NN61pm5J0XxoBKdqnwtRliV3PeBWSqJcuyIa/N8nbJCq/AKvLi7UlhQguVwOC/jZbBpBFhl3iDZsD4ghD5VaoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4876
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209060091
X-Proofpoint-GUID: W8fPS8yXG9A7spzon2-8lTJs1vifEGdh
X-Proofpoint-ORIG-GUID: W8fPS8yXG9A7spzon2-8lTJs1vifEGdh
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

Pass through ULONG_MAX instead.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/memcontrol.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5e0fa278eb53..668b6792fd1c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5879,7 +5879,7 @@ static unsigned long mem_cgroup_count_precharge(struc=
t mm_struct *mm)
 	unsigned long precharge;
=20
 	mmap_read_lock(mm);
-	walk_page_range(mm, 0, mm->highest_vm_end, &precharge_walk_ops, NULL);
+	walk_page_range(mm, 0, ULONG_MAX, &precharge_walk_ops, NULL);
 	mmap_read_unlock(mm);
=20
 	precharge =3D mc.precharge;
@@ -6177,9 +6177,7 @@ static void mem_cgroup_move_charge(void)
 	 * When we have consumed all precharges and failed in doing
 	 * additional charge, the page walk just aborts.
 	 */
-	walk_page_range(mc.mm, 0, mc.mm->highest_vm_end, &charge_walk_ops,
-			NULL);
-
+	walk_page_range(mc.mm, 0, ULONG_MAX, &charge_walk_ops, NULL);
 	mmap_read_unlock(mc.mm);
 	atomic_dec(&mc.from->moving_account);
 }
--=20
2.35.1
