Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A00C52575E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 23:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358933AbiELVvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 17:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358936AbiELVvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 17:51:00 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0F11A3B1
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 14:50:58 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24CLIV23024581;
        Thu, 12 May 2022 21:50:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=mvpqJN9DORHVVUF6DyslqrPFLJP1BmfxP9G8F1ZaVbI=;
 b=qR7uVAIkdw+6zWr4nLH48v5my/ehaGVvo01QIWvu5Ruuej4ggyQgTCMiQ0nts6hFCUD7
 54V4GUmF2lz/PX0rpDCKYWczVb0D39rNjxmkRbXwgmmBx1LKKf7R6lPS8kwZAGIYL6m6
 RcYmkfSGgFldlMRNIw3ABHGSb4e8oMXxS3xTQpzvB580QhbpfzaAtnjW70KfE+3egIx6
 COvdQtW5XxFnMroxLksebahMHwf3o3ZVWpwC8ZcrpjCRyyK9bI+oHhsLXK9faLpanWRM
 zfS7gMJQIsYxadU8chwM7SAnyxaBklHOAyXS0FWF4vxfoa9pyNrNn9XDV2Hf18RMqx7U NQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwfc0x0j4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 21:50:50 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24CLfFrl023522;
        Thu, 12 May 2022 21:50:49 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fyg6gf4um-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 21:50:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OxCH2pe7O8jwy5LEoHlt3RT/zEZLym0VeXYMvG5GK1jBV54WxmwsWFFhFbnXlnU5uLvTsysShLEbFwZwa9fYOZMlTrbAnZ6VUONsQEAsmk6cN92Z5VJQ6UPqN+yQ/QA4I00I5A2qFtbIhd05D1XacXjDb++RTZvOAnBlBa3MhFCxvPj+ulK099DluuBMa/vgQeDRUFx9aeRHsbCSkmricNYF8S8aPWkiQEMrjbibnjNh0BgUZO3WU8X2kuZWVHfOn+hgmzkhzpzwUENJSE1Wo160ahmaPitRkPUPn4ys4z01TvLTawRDyKu+S94+gwLIP82Ifl77+W0gQo7xvpge3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mvpqJN9DORHVVUF6DyslqrPFLJP1BmfxP9G8F1ZaVbI=;
 b=emHrcEXD7nVE3HSjUJazuXmQ5ENAnGJaENa8C8Zy705aFsd358Y1Xgibs9DpnVz7/eZyAkA0KXKEE+zjJsCy8cTPu6161mO0Q6gmyEUAUQLA+CB75N/LbVqZd4ZT7rpUWKApNHBC78/4/IE0LW3fivHtZxaKdpmK+C/dRt9dPhMLpUR2pgwrkEDHqk0hPY53iMs/Xh9notQvHuaLxGbOqtO8Rgn8xepXrez0l+KweMueDD4zGRN7iHWXWyxm8WkA08UABzb6NWyW7G0S+ScofIyn1W5e8neMdxLanRcVEodPTBV7l61WijqRkNBU+qAIOrkGopaThyh1DXL6iVKwWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvpqJN9DORHVVUF6DyslqrPFLJP1BmfxP9G8F1ZaVbI=;
 b=MW0sCqWS6BbsEPiN6INPW3QyHA005o/ijrp6WNaWDhQGHWMFe2IJG+86ZAt4rJN+66XcHaAewtcH9J+xDuKZjCcrkbAUB14O9XeDQWpPcaKj+JbMqZjZfO23V9BmwrOizNcJTENIdLpy7pOhvt851a3qHW+mmyt+R0GRpXGFS58=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by DM5PR10MB1564.namprd10.prod.outlook.com (2603:10b6:3:9::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.23; Thu, 12 May 2022 21:50:47 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::4421:897e:e867:679c]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::4421:897e:e867:679c%7]) with mapi id 15.20.5250.014; Thu, 12 May 2022
 21:50:47 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Len Baker <len.baker@gmx.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Stephen Brennan <stephen.s.brennan@oracle.com>
Subject: [PATCH v2] assoc_array: Fix BUG_ON during garbage collect
Date:   Thu, 12 May 2022 14:50:45 -0700
Message-Id: <20220512215045.489140-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87ee0ys9od.fsf@stepbren-lnx.us.oracle.com>
References: <87ee0ys9od.fsf@stepbren-lnx.us.oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0081.namprd11.prod.outlook.com
 (2603:10b6:806:d2::26) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4be18084-c3d6-483a-40e3-08da3461792a
X-MS-TrafficTypeDiagnostic: DM5PR10MB1564:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB1564EA9E93781CDC7D397C19DBCB9@DM5PR10MB1564.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2O2CkqB4ovzSBMaXbos9M/c3bOrbpbYH+RNKJCfWvJZWEBE8/jjWkW3z/zY9IywGbLJdb8+rDWgSovliRkCrUkpiPaG1MztnfjxJJts9LZDW410YWO6rVonCeKrloqcQyFQbZtAAc+U6WmwSZ590eLmdqKLYxoJ0eB/bDPGd8SkOh34lqZs1d9mveolkE5jrZI6IJZfNFtfibs3A6xCQcg27OYeKngQ1lldXObtujZ9h4KjjxvmslVTK5vD3mQu8T3FmmlqiFNsPamMYzi5oerIl+0oLPsJTI9KJrpFqmW+am4/M7UzHah0VJcRaihT/215BZAPROqir4b4PKGqbjQ/5eTPS/5JuHCdos1UZloczSOjPGF9mf9a+7cDhnTsi2kWXErwdLlopoKT0iicaJIcswwoGlUJcMIbaZEhxh+n1croQaILItSWJst/Hk7y6s4b89LmFljs8EDNkQ9OAN3BBGtSBaiJ65ML6TK0prKnLe1UTpShtqOLmc4wg7+vSGZgJHoRVUwyrqi030Y7KddcKwhrIMqJDNvF7MB0w9G4nwEqgS1D7mJM/ywknLvtmgBgPsgU6D53RoxcrFfjACoWPOrxdmQATFHTvTqLd5BKTx91F6bd3+rmaJ/3t2NJTMBByehqYkDizXtObxgohI0C2zy8nCo5FwRM3HOu2O8OupBKgWUN4owvPABkRX/sYuV8b8HJk8eFlJfl6Io5wNiOuFYziZiN4CGfkohKz+bIDim/HRksIZwEJhxtiUtzkD6TylUAZkKSOhFqS+bPVZKv0Lsvjy1C08EbjrGDy6+M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(52116002)(6486002)(966005)(6506007)(508600001)(6512007)(2906002)(5660300002)(316002)(66556008)(107886003)(66946007)(186003)(86362001)(8936002)(6916009)(54906003)(38350700002)(38100700002)(103116003)(1076003)(66476007)(8676002)(26005)(2616005)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zzoqUHbzliXDQ5CPrv//oQMQ1DZaPhVCGw6enzcTdxJkiLFlHV9S/KJbUHYX?=
 =?us-ascii?Q?dRhjxc3tYn6YYRSkzuwUTBxUab2GXdhcnlz5l3Jn06ymW6vULt7UfXfe5zfR?=
 =?us-ascii?Q?3Jy4XXcbTeQ09aEJxkTZ0KsUxUd5f9xc8zDNHQqgBa9NZ/EsCWhDosU02HHF?=
 =?us-ascii?Q?kZgk5caknpoglhawI0samEpQinPBdaI1JcN29RA4t1jrZkMuBEk4sE+UjRNQ?=
 =?us-ascii?Q?31ugAYnI7BW8+CYIaBmulA5ECRZrhZUQx+ZqDR7MkGVnKDJBpAqZwWydpDDg?=
 =?us-ascii?Q?XRcyjEZXar+sjPU5YjnpqVNwdFqcwV5Xjh7Q0wEcIuRTn++mvvwN9GQCQcOl?=
 =?us-ascii?Q?nYhuIN9F64ZrG+MAoUJTYrH4YAyJ865maAujZBtkfOeXetXuMFX+DSkX5laq?=
 =?us-ascii?Q?bHLkYyODugSGW5S+wOuTJSztkLcuH3Ozslql/xD5yhk9uGr4/PDKWG2mVDvU?=
 =?us-ascii?Q?uRgexSifcx5811IojONwMCqq9nZso9o5L9kAbqU6nOz1LE2d3RvKgrRknM0e?=
 =?us-ascii?Q?jiXZV2NQDfO7NUUsImrsxIFDbwN5vyCeP2N8AJ+Sw/ZdNLG87IzjGZ2gAUP+?=
 =?us-ascii?Q?vmpPQAVv7rG+WHj1+WWSmF2vm5jlMEnA69yCe4HPITVDp2Se1u2S8xzzP6oa?=
 =?us-ascii?Q?v5Z/qCn2YRjsiUQO/+VPcOxaRjUSUG+JmFZy/7bi7oaaaO26Lbhe56vWFFIT?=
 =?us-ascii?Q?4PnuahZxezPCyxLSXVVZhBDbxpDIpBLAb3guJ4Wkzfaym32Ec+xqucQ8wDWe?=
 =?us-ascii?Q?UyX8NGULD2Wk8rJNX/ydBmh6cve0tiMbdoFVEfOSRr/cb29wQL+AnSoKKj9W?=
 =?us-ascii?Q?QCb/gmwW+inD6GN+3bShk5RqTitRwBxQLEjcBwdUG7cqcV50qgN/uW0bL7S7?=
 =?us-ascii?Q?KWiB8cX8QQ6uWKpK1uF0T2fv7znbzv/e6Jim9X/TUI9/qa4mT/S3O65qJjXC?=
 =?us-ascii?Q?erzClVXBLzisAoTZ+ps/2krdd5HfHkpfh11emIfLWeT8bSInqllELEEr1STQ?=
 =?us-ascii?Q?mnFStjdEUKRioSodQXIaVTztYc9yc+i0QEJ4odLkB7S2SZ/79S1J6tIxZlxl?=
 =?us-ascii?Q?cbNTDqMJI7aSbLrqYafM5YeslDz0NXpXhc0aDQ9wc/LatBCeVN/lHKxnpK/6?=
 =?us-ascii?Q?sTaFSxj71JPiLoFP9KHXBcPFnsHu7+Y7CTycfE+qQMzMlWe/Bf4JD6BLnQFe?=
 =?us-ascii?Q?AabckBZpit6IkxzFTOEbE4egJmNdvf1yBEjwDsI1o2IOmCNU6IPFZpi2DgSK?=
 =?us-ascii?Q?pu5G+czAxWZUHC85/LJBgLdn1jCG+OCKizBcSscaBHtMgGNhQTrbnja4KBdJ?=
 =?us-ascii?Q?+NI2dw35v3LhxWL3sWaS2W4c4XczsPNF4BQyOtvvsEtBWwn6nBiEL3NGqW2K?=
 =?us-ascii?Q?46AIAgign195WpNRJ2kmHubyt0vwJxeAsBc4Q15TZgnTP9cYK5Ff5SzSvwOJ?=
 =?us-ascii?Q?V3B22WZXz7CWTHGnhDEYgG0NbKYGco8IB3tSSI/JBmGM7jQyVngT5jkww336?=
 =?us-ascii?Q?+107mgfXgebI0lGQ6bktsWCoO1m1qUha9gKhTpTKN339j+Eu14+XRwy+HXzT?=
 =?us-ascii?Q?P/Hw0k2S3bkhrjM2rY9uW+000oEpr7a9b6LnpisSBBLj5LnDr7qgoI4fXWLN?=
 =?us-ascii?Q?+mGu+03bU3btvJEthL2ERusjqRXU+JsHbsKBtqnt3XDPyY8/RHqvhLVzTpQB?=
 =?us-ascii?Q?9AJvDo8D+/rJec3YjbMqdn4sbQz2aQtEq2dLWxWivcmMIZEuwGpoHZSPqemT?=
 =?us-ascii?Q?oQ5ZxMsk73CHPSGOkXSsZbdiC7CJRzQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4be18084-c3d6-483a-40e3-08da3461792a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 21:50:47.7661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1fanp7YTI+fiSCI3nm+218OGRvZTjHOONCquT40I6IsZcKmUBRBI9sCwOJH64EYPagWbmjSw4xqfiwrpXIgVxiUWqyA0kuWQAXOBfQ3udqU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1564
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-12_13:2022-05-12,2022-05-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205120091
X-Proofpoint-ORIG-GUID: EfFRsY8tW99T8CLIG3s48VhXPAzkhDAm
X-Proofpoint-GUID: EfFRsY8tW99T8CLIG3s48VhXPAzkhDAm
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A rare BUG_ON triggered in assoc_array_gc:

    [3430308.818153] kernel BUG at lib/assoc_array.c:1609!

Which corresponded to the statement currently at line 1593 upstream:

    BUG_ON(assoc_array_ptr_is_meta(p));

Using the data from the core dump, I was able to generate a userspace
reproducer[1] and determine the cause of the bug.

[1]: https://github.com/brenns10/kernel_stuff/tree/master/assoc_array_gc

After running the iterator on the entire branch, an internal tree node
looked like the following:

    NODE (nr_leaves_on_branch: 3)
      SLOT [0] NODE (2 leaves)
      SLOT [1] NODE (1 leaf)
      SLOT [2..f] NODE (empty)

In the userspace reproducer, the pr_devel output when compressing this
node was:

    -- compress node 0x5607cc089380 --
    free=0, leaves=0
    [0] retain node 2/1 [nx 0]
    [1] fold node 1/1 [nx 0]
    [2] fold node 0/1 [nx 2]
    [3] fold node 0/2 [nx 2]
    [4] fold node 0/3 [nx 2]
    [5] fold node 0/4 [nx 2]
    [6] fold node 0/5 [nx 2]
    [7] fold node 0/6 [nx 2]
    [8] fold node 0/7 [nx 2]
    [9] fold node 0/8 [nx 2]
    [10] fold node 0/9 [nx 2]
    [11] fold node 0/10 [nx 2]
    [12] fold node 0/11 [nx 2]
    [13] fold node 0/12 [nx 2]
    [14] fold node 0/13 [nx 2]
    [15] fold node 0/14 [nx 2]
    after: 3

At slot 0, an internal node with 2 leaves could not be folded into the
node, because there was only one available slot (slot 0). Thus, the
internal node was retained. At slot 1, the node had one leaf, and was
able to be folded in successfully. The remaining nodes had no leaves,
and so were removed. By the end of the compression stage, there were 14
free slots, and only 3 leaf nodes. The tree was ascended and then its
parent node was compressed. When this node was seen, it could not be
folded, due to the internal node it contained.

The invariant for compression in this function is: whenever
nr_leaves_on_branch < ASSOC_ARRAY_FAN_OUT, the node should contain all
leaf nodes. The compression step currently cannot guarantee this, given
the corner case shown above.

To fix this issue, retry compression whenever we have retained a node,
and yet nr_leaves_on_branch < ASSOC_ARRAY_FAN_OUT. This second
compression will then allow the node in slot 1 to be folded in,
satisfying the invariant. Below is the output of the reproducer once the
fix is applied:

    -- compress node 0x560e9c562380 --
    free=0, leaves=0
    [0] retain node 2/1 [nx 0]
    [1] fold node 1/1 [nx 0]
    [2] fold node 0/1 [nx 2]
    [3] fold node 0/2 [nx 2]
    [4] fold node 0/3 [nx 2]
    [5] fold node 0/4 [nx 2]
    [6] fold node 0/5 [nx 2]
    [7] fold node 0/6 [nx 2]
    [8] fold node 0/7 [nx 2]
    [9] fold node 0/8 [nx 2]
    [10] fold node 0/9 [nx 2]
    [11] fold node 0/10 [nx 2]
    [12] fold node 0/11 [nx 2]
    [13] fold node 0/12 [nx 2]
    [14] fold node 0/13 [nx 2]
    [15] fold node 0/14 [nx 2]
    internal nodes remain despite enough space, retrying
    -- compress node 0x560e9c562380 --
    free=14, leaves=1
    [0] fold node 2/15 [nx 0]
    after: 3

Fixes: 3cb989501c26 ("Add a generic associative array implementation.")
Cc: <stable@vger.kernel.org>
Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---

v2: fix typo in pr_devel, correct comparison to "<="

 lib/assoc_array.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/assoc_array.c b/lib/assoc_array.c
index 079c72e26493..4c4967b13b2d 100644
--- a/lib/assoc_array.c
+++ b/lib/assoc_array.c
@@ -1462,6 +1462,7 @@ int assoc_array_gc(struct assoc_array *array,
 	struct assoc_array_ptr *new_root, *new_parent, **new_ptr_pp;
 	unsigned long nr_leaves_on_tree;
 	int keylen, slot, nr_free, next_slot, i;
+	bool retained;
 
 	pr_devel("-->%s()\n", __func__);
 
@@ -1536,6 +1537,7 @@ int assoc_array_gc(struct assoc_array *array,
 		goto descend;
 	}
 
+retry_compress:
 	pr_devel("-- compress node %p --\n", new_n);
 
 	/* Count up the number of empty slots in this node and work out the
@@ -1554,6 +1556,7 @@ int assoc_array_gc(struct assoc_array *array,
 
 	/* See what we can fold in */
 	next_slot = 0;
+	retained = 0;
 	for (slot = 0; slot < ASSOC_ARRAY_FAN_OUT; slot++) {
 		struct assoc_array_shortcut *s;
 		struct assoc_array_node *child;
@@ -1602,9 +1605,14 @@ int assoc_array_gc(struct assoc_array *array,
 			pr_devel("[%d] retain node %lu/%d [nx %d]\n",
 				 slot, child->nr_leaves_on_branch, nr_free + 1,
 				 next_slot);
+			retained = true;
 		}
 	}
 
+	if (retained && new_n->nr_leaves_on_branch <= ASSOC_ARRAY_FAN_OUT) {
+		pr_devel("internal nodes remain despite enough space, retrying\n");
+		goto retry_compress;
+	}
 	pr_devel("after: %lu\n", new_n->nr_leaves_on_branch);
 
 	nr_leaves_on_tree = new_n->nr_leaves_on_branch;
-- 
2.30.2

