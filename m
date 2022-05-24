Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51758532164
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 05:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233780AbiEXC62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 22:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232538AbiEXC6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 22:58:20 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0029CC9D;
        Mon, 23 May 2022 19:58:18 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24NMi0YK002653;
        Tue, 24 May 2022 02:58:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=hCwmoTdrJdTxr+lDv04Zlj6RSj5+92JKNmS3/lwNZvY=;
 b=xfFyuGyaHrSRKEv+NGn16k7g4MQRAxsAruNWP0eR6unvqYJ799dOFFBDz6XTg95QOCSG
 rlLQN+U3W9/4+mpp+ANmuza/H19+cwNw6CyYcbXtHIXHanX5Zxej3y39cKCzj6kIy3WH
 +G1L4gn6KU6J3SUXm4dPhhn9zVSdVVhJe74M3HoeXmK0ksTUG+dejj9DIIwPkQ7f59TB
 TIB9s1riLNB2xkHMVJCTL2pvfMR/dSirNfbgYiRf1VjrtJEYQAVlacFE4UNUx/xs75MK
 nvBbsXorWe8QeU+MY8ub75v5tLoCFdH/3/NnD9OxqGQLXP8jFEHlpNTmwFUsoc85sURU yw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g6qya4xua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 May 2022 02:58:11 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24O2uJ6v008698;
        Tue, 24 May 2022 02:58:10 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2042.outbound.protection.outlook.com [104.47.57.42])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g6ph25w7x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 May 2022 02:58:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h6m9eVY4VWSIwok72GXuYbSooIBGmodlq2Z6IgifMzpdPpQ3cTy5J54PdDwjAbOWn85tL/PYBz2tjsxTYwbQ9gGcTf5ykVt1C05fztr+iDj9c7T8gUUZQAnQFRevyVqCgqHUc/72AcojuI9GlATuDsQDlS2EvXBmfUgAHZ5tFLzm9OcaKtjZb4NVGeMI3JwWzrjOGs4r1tZ09K3O35IvgEvdB9PbVwsWxIcMiRFS6tFlsjvZ9r54eDxCjdUMV9fRSHkbg075YlXvLsM+kvM7VuSA+w4EnZx6x7oXfpLL/CPnr944LBe2zzCr01aXiR36Gsn/Tu28BwD6RjLSZJL2zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hCwmoTdrJdTxr+lDv04Zlj6RSj5+92JKNmS3/lwNZvY=;
 b=ZZltNtq02KzsMjF8uxCVoKAjyGWJuxPIBIbFKA5pZVDDaK3BhzVrrLXur9pNlAHtfMcCu4l4Cec6LXSVZj0TXpY+aIvvdlCxt8P4uCVptmluMuQH7nFj5POAX6HRHa36uybwWPJ7alX3tP6VRZKTJvVSSoqhb3qDq30MWYVSDVgxSRlQO3ZbEFMWaB8aer2Zjh60o86kKlGsBGbbkDU5XP0TYgmDWLPAzvcy2HvDCcfGHdJtDZobyHh3zyM79FjqRpc/4iIqfkxCclA5/0wBvR0xgMMTKBxtmwxR7m6KnSDJGNcZlccGKX4ZnT2te2h7C0lTSLDZEa3uKwvbDvORaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hCwmoTdrJdTxr+lDv04Zlj6RSj5+92JKNmS3/lwNZvY=;
 b=w1LxzwvnSLvhwx4wa0m76nI3w+KswYUwyBUKTeJ4HV1WUpg5NsnO+e5I5OBPnws5ZnnYQEH5kV/cg0g7JUdRsAhmmV8/oWMfhedWaYoAyN2NaWM9tZh3H91QywOj+riCoKeFjmrCHr/p4P6nmqfJ++lR9Wn4ezk+LEwFFE54rw8=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SJ0PR10MB4685.namprd10.prod.outlook.com (2603:10b6:a03:2df::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Tue, 24 May
 2022 02:58:09 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192%9]) with mapi id 15.20.5273.023; Tue, 24 May 2022
 02:58:09 +0000
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Bradley Grove <linuxdrivers@attotech.com>,
        kernel-janitors@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: esas2r: fix typo in comment
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1h75fiqmf.fsf@ca-mkp.ca.oracle.com>
References: <20220521111145.81697-40-Julia.Lawall@inria.fr>
Date:   Mon, 23 May 2022 22:58:07 -0400
In-Reply-To: <20220521111145.81697-40-Julia.Lawall@inria.fr> (Julia Lawall's
        message of "Sat, 21 May 2022 13:10:50 +0200")
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0201CA0061.namprd02.prod.outlook.com
 (2603:10b6:803:20::23) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02ebb129-3a83-40a0-6bea-08da3d313b90
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4685:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4685A4D33AF6B9025D324E878ED79@SJ0PR10MB4685.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ltEdXnK7Z/p3poDGLe52XAxRyoxgHEXQhhcjrgtN8vFdnA8+gu3YeDznQQBIsSzdiGRcUrXeuWp8JqaQzE0BLp4rtVAVEwprbkgLyhbjXuyUMyCHqgcwCODHe568vw3/3wU5rY6aADHviE/edFaK4nRtN0f90zr4Er/tGN8r+Z0GqcC+VcBLfLUfvBIw3VQMWRtG3MEvFNalTfLVyFKj45AOHVvfI92gdjO2tkTHSyT2GKsSla0ythQqtFyIzmtAzqUsMzL53P0BpXmIfLtrK5GR+odl3Ta6q6FRXetWe6vr0Fdaw7KK4ScS5yUK52Eiy22I4jOIRgpMg9+8ZjrAQaU5rxRakAhYmSxrxl99OKAzqLmd0W/7mLnXMfFxGWb/bfeAd1C/+XND4itkItbVhU6ABRnq03ffzNNRD+JfCoMBicbFvOgShah1R/azhiwV6HvllB8NBj0Tbpa9K1NT6N5mrsr0ArY0ZOwBtX9EBew06WRCh72Fvuad36a0ZGXuGlB1Rktbp0B8oYYgF5K+cQTuB8P+zJsB6ciSj5QIunQ3cwuHXk/Ug6AW7ZzwqZ587h6YphQ2pTHfWgrYTpDiJMy/GYlc20O9X6K77DmMIPog07bk77B97rdiRbm/9940s6e6a5bwStC41m2V0834qMG3Ooyxj2w2jBfwV0P67tS7MqpoizoqCWHI6DJMmokLbUqxpMnsyaoX8rokdz27eA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(36916002)(38100700002)(52116002)(38350700002)(6916009)(5660300002)(2906002)(558084003)(54906003)(6506007)(26005)(8936002)(316002)(4326008)(8676002)(66556008)(66476007)(66946007)(186003)(86362001)(508600001)(83380400001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Eob2JcQf1QjBqPxDX2WY2epgJC5OsPsdiET6ijiJFJfX9WnkIc8FA2Q3GgVJ?=
 =?us-ascii?Q?P29wCTC6jnUc2IVcU2t4sZiCpIph3tS8oKNKSHLnriLvuALXp2kDAen/wto0?=
 =?us-ascii?Q?+CRj5CV2GnBxukXJCzBdnF8MgXdGxYZDGBZ4h1sNv248qY0p/toPFC9Wor1S?=
 =?us-ascii?Q?1flgHujNHvolDr/CgHKp75WDWdlU0v6HUbm+4ASYNqGvyu0+oP5a2pxFXi0q?=
 =?us-ascii?Q?zi7NgBiIKelUZOFBOzRB/IrrkVlwURvfV9u0fPRVMgP6kMHXsgZMvxIxv9gq?=
 =?us-ascii?Q?Q1g4RDJhlJPPJhzmG+SEXbm75Ao/ohHqYhrWUe8p5MHGAyS3MeOUAsZdb4F5?=
 =?us-ascii?Q?AV93QM9v4PsQ7NyrqtpYSC6x70xLy7uGNFifgNL0sfG4RpvjH2LjfiNSk9WY?=
 =?us-ascii?Q?jaCNu6w0NoE215SSKelLwIbzfMPGUHKiOpwRguYNA84srd7wkr87cRzDfVhI?=
 =?us-ascii?Q?uJG6+1aahSmoqi5f+Qipkl+xrWwrhhVR93OPlrscRFkrnTp3j3GkXhBPORkH?=
 =?us-ascii?Q?wTO/v/Zh1TNwouLSCS2PHlsu0wyWZl4JT8qLGjLLfjqg+k9V08en/aPw7cN0?=
 =?us-ascii?Q?pdukKUksdQlwvUTc2Li6dbK5oLGVV1RJ0ddE15JxLwEIQdsuKH8OP414cNYM?=
 =?us-ascii?Q?hz9cwO2eaw6/JoFBDxj2sEYtfMSzWiRmUzdJaPchetL9OLnl3f261+uJ/Mhr?=
 =?us-ascii?Q?6nE3j1+8gm64cKM/u7oxzv9auyBXwOFu2dhqwHprMJBHRiFfxgQ2F2FQaRrz?=
 =?us-ascii?Q?eV+BxsJhZnI6Q0JK1N3WcuAqt/p/L13bzKsMHmkUn1i+cHh2sO/+9vdwluZu?=
 =?us-ascii?Q?opzs3TzsfuFrsigQYJ7W8e11Zl0EOxbqNUkafPl2HQO3hZ84fO0iBT2EuxbX?=
 =?us-ascii?Q?FgR0zei79Qb7QebcIG7MP1qZZepkp+PwR8PykvdQRDvQPj7fjAN6qLOTPDlp?=
 =?us-ascii?Q?sXVm1+zM04kdCRQUCdgAxsz9ZXDJ+yHxrrg6DNIYZcX3cnc2nXOepktPfNHE?=
 =?us-ascii?Q?/+OEy9qgaK3vikw3/5HAnQ0xyTLJSfnT9lIuw4yj/d7Isz86vc9YOERDv4MV?=
 =?us-ascii?Q?dJUn+0qJwgld/news3WIsCkazMHikUxQqn06t50eZQolXvmv/RcFA1gY5Qtu?=
 =?us-ascii?Q?kdb7XdnY0itlKXyTg5CzCXGl4/aS6+zN01NJUV2t/i4057ClVbcP7RUhL5lh?=
 =?us-ascii?Q?ruk4k1ZLkX1VU4/y+hnpj/rayKMGUy/w0xaxc20ackeWAYYYZahVDKB9F+Pz?=
 =?us-ascii?Q?ll4gMwwTBf3qirK7jcYHY5ECKGk1rzaEH5FG/WH7D3dBlnQcLFozL+cT7fFS?=
 =?us-ascii?Q?+8tMU65DAqol4Csa5EzpB5Cv6KHPEkonPIzsyzwFCCjTwc0k9/WUehpTslVI?=
 =?us-ascii?Q?IiP5MjTfTzEh0ovG6ilbDGFVN4aVDSkNEFN5H0wzaiHdJrfjur2ipJKCyZt1?=
 =?us-ascii?Q?mcrEmh4GJFZ9f/ZZg9dRm5Wz89aJ/8+H11S7zntM/APP1Zzm0Vrp44wEP1Fl?=
 =?us-ascii?Q?OGwu1m5PqntVC4v/w7LYU+yRDaewAy1r7b1TzkKo5LPruZfnHXy4vUz5tCkT?=
 =?us-ascii?Q?483cDL3twSmWvqZR3vJGEg5Tn8SE0YaOb4yrHZELZJ5f3SxQSsQBnbiE4+6W?=
 =?us-ascii?Q?LLer5IyewadToCPQxeeezs2Tr0xS/6pN+d1TILxN3nxnk3U1N6HHhlygBTxv?=
 =?us-ascii?Q?dzdD+GuM96NFm4Jw2/8whdaNXrPGqRwi1p/qIuWbJoWEjTcUHNcGMEcC1euS?=
 =?us-ascii?Q?ReNxypd8N2wqjzKd1EWiHz9m1QC5eUE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02ebb129-3a83-40a0-6bea-08da3d313b90
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 02:58:09.0389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 52SdzwdNyOFOaNoPXJUd5bsJOJYURx4WTK6Pc36wyAsqtRgs5PenTzdHRBAIpvuo7H4NVYygLX+bEzI6rhbjcbIpG6qKY6LEOVBaYthfarc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4685
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-23_10:2022-05-23,2022-05-23 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 phishscore=0 mlxlogscore=840 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205240014
X-Proofpoint-GUID: 6SSQBWAJ0koD0j_4YzV0X3ntxFTaiEHs
X-Proofpoint-ORIG-GUID: 6SSQBWAJ0koD0j_4YzV0X3ntxFTaiEHs
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Julia,

> Spelling mistake (triple letters) in comment.
> Detected with the help of Coccinelle.

Applied to 5.19/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
