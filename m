Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAD456BB1F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 15:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238259AbiGHNq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 09:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238196AbiGHNqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 09:46:55 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548D62CC95;
        Fri,  8 Jul 2022 06:46:54 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 268B8DTL026591;
        Fri, 8 Jul 2022 13:46:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=zwpYPTNWjkEYdm3Ps2W/CNy58vir3UXaubtzeM/RJ4g=;
 b=uHMRqaeiufX9cTTeV6J4mJlRfUlLrqHEWZEygDS5cNxKPs4kST+IR9nICEFdjURu4GUw
 UQjPMe7m9T2hSgZHwJVmi7gOrH/VbD8MRprNmDW5uSafbS8y1O44XWACNvPO9cLXxdJB
 z09KE3GLn3BSUpwW+T1dfTXP/5UZC8sG6x/34vlRGPc6QV7hTC+Pp8rdXFLgUuaPvYLC
 ZDveHYjvKuMSjXL2ZYuPYLQsDQ8vhdkYE4lTqGoJT7XB9upydrvbvgr5Jm+BJFUvu+EC
 c68ygTC076E9VmJPQZg7YyfvxV81Y4dzl2nelRAuK9caM+z7DFIbU7pPJNOf1JuQzNcS +Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4ubyg6q0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Jul 2022 13:46:51 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 268DeEJs017603;
        Fri, 8 Jul 2022 13:46:50 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2177.outbound.protection.outlook.com [104.47.73.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h4ud7pg7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Jul 2022 13:46:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bU2rAXRcP7G+/SHyZo7k7ZtMFmm5zuoQwM+SLvUbzVckXZz00aFCKXmQyGRRxjUib1oqgNoGAUO+6moEd3jo/9K3OsiDo0f2vsSpaTw9hX0/8/mjZ1s/ilDFDoSeShpHmUlH1pdNfwFlei/KTBZDWQtR2ry77VydEzPJTRnGcH9mdyckwrXPF1lAi2+bO96WflU38lr5zByjyQhpzttTv7XtLNjWZ1RJ7IxPSTObs/4+kXPEzBt8AionjDmpU8ks8cBl2/uEf32b236CMr1ACPxl6FYbBI4e/tDTe2Tt5dmz+TOetXa/pG2O8swlBojF7TKmk4A1QnPyNa/515+CFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zwpYPTNWjkEYdm3Ps2W/CNy58vir3UXaubtzeM/RJ4g=;
 b=DuBGNsqkONBu2wcYwcjXKfxeBFcjdeDQBliTNAlDFy63ZbwJaDB3CRfoBVzzMLOSl+zk73CcOYK8ZZX9QRhIa4kiCsaZQke9dZ48jj6kACoiOWyhOy35foycp7iSAkNK0KHo9jlCvkL+BlmPRxu3olBUEYpDrj2EsRO9p6576G2S+VwFvWBkQEVBNHE1U7SUtaduJrShMmVLk75UepGyLMFcT1c71u66R/BW6f0HxrAsNiCnMP8OLJ06FmM72o9jf16S7g9DAqwC2+hNxIsDHJVaDDw1DKkJYRaBxovLihQhxVirpLouvDXZZRf9F59yeTA+KzjdF0EnadtEpSF6+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zwpYPTNWjkEYdm3Ps2W/CNy58vir3UXaubtzeM/RJ4g=;
 b=xxup11WB1TZTI1Nr7lonKr6NRUACm7g/uKfoegyxOigWC50/aakz8NjO/Z67FhhWtLa1vjf6YEr94Azg5f5Gy/Xml7vzkbkYy92AZGsZ5dY4nT+NIPBhUonXYFXyYWW3hNtpZN4rOJLEzzMfRdpvm/72Z9ynkXAkrc0ZI0+sIA8=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM5PR1001MB2220.namprd10.prod.outlook.com
 (2603:10b6:4:30::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.17; Fri, 8 Jul
 2022 13:46:48 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5417.016; Fri, 8 Jul 2022
 13:46:48 +0000
Date:   Fri, 8 Jul 2022 16:46:38 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Serge Semin <fancer.lancer@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH v2] eeprom: idt_89hpesx: uninitialized data in
 idt_dbgfs_csr_write()
Message-ID: <Ysg1Pu/nzSMe3r1q@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0034.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::21) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1a831e5-3743-40e3-4206-08da60e84dbb
X-MS-TrafficTypeDiagnostic: DM5PR1001MB2220:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a8NC6biD6yqjAzPW8pkdWNq0bA3Q+aNrhU4hqMUG7gaqg6mTmCPm/y68ReryhZAUcVCdkBwt84jk7TPWyrPzERl+QGyGBdj13XRtvvx6YpZf6+wHXkt+FNHfk1M2n0xqrQ4RdI+dhAHZOcAkot5xKrzwzvYpUC09BSmH1PXliBTgea9TmoogorVxx1+o14cU7GdS5+sBwwqy6R5qihufzlEOuwRKccBLnbGQGb2SKTqtmObXTdgVIe8DghhTIqoi1fXZgwplJ9g2NegykfKJd2fBEfLO6UuOwj9Af904AnleRdqZj/CzEZxbhT5NH31gcKne2sEOVpzkQEBjz9o2lly3aW3A8hiigvXRx5moFczoM0LevYwAemdivuaA/oTIuwcpNce6T8ad+xiuXEHBGR8VnKNag3ljoCzC704nYjQtxbJpkXzEP17cQF7ICZzrqj9hjElc89E1ZOUzwTV0aUVi7mLZcE7KitBtAFpl3fWtaKQZMxQOEJHPojQhBY08CXwHvk/3V18lMdrGJ2ijdxayV7T1bkasc1tqa8TxLyObzCWbXFgU8Fx8hR7dmznGlFcehk2WJk+Ge78T1rEJCZM5H15fgxpkv0NvIz3+nbr0Js+HX442I8oimtLJQePDh/DArVdAGEF75Ycr3sJuKfAvHX9EtEg78k6MBjx5j14VM0TKbc2tz+NoF5kNeX41Arlgkic+yaIrwZ01khOK4dSBmHEiUaxwdabwTwdIP8S2nkLlWYSbGwxW5pR+j/GLaP3eJ1cryDA3V0/fQIyK3L9GHFZfAqojk9bOuuwctRU0RJyu62u0GdOCwr5L8CCP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(346002)(136003)(366004)(39860400002)(396003)(41300700001)(6512007)(83380400001)(6666004)(9686003)(66476007)(66946007)(186003)(26005)(316002)(110136005)(6506007)(66556008)(8676002)(2906002)(52116002)(38350700002)(33716001)(5660300002)(6486002)(8936002)(86362001)(478600001)(44832011)(4326008)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/ip1rpJtFrraW4ctT475lzAuSKF494bsSdqrX7JipG3KyCGP3oow+ftVMbsS?=
 =?us-ascii?Q?4my+D3XULze4LK/8Ep8JYPn7Sg/aKwlWSKlpPILQMvpAdVE0Jx2aW51lQEC3?=
 =?us-ascii?Q?XVxxbpxyw5mLnWMlGayx6OMdXSuGa5aMxYQrEOeXRT53zkkZTSBjNar4njzL?=
 =?us-ascii?Q?fqizlYxH2dC9m4gnvrOPwDoVxc1RZdWFU4TIc3szq+fBZWKA6TEbmj0w4a5A?=
 =?us-ascii?Q?R0QFZ6ltd/9yDXAfnLbeBunhbfALj3c+gJLJNL25lGdw8nTrrmwcDAdFwQ4k?=
 =?us-ascii?Q?I5ZXfbiXu8MY3rSe2LS492QJfF9WdxHj31/Z/6Nm5RYTfCPAlvJBbYxBq7/S?=
 =?us-ascii?Q?rc5v9B2CSw8ymn54tVifKZTLxQcz/H0TFAgJ+OSqgZx6rD4dtE/s3t8ulWQ+?=
 =?us-ascii?Q?AbROcL+dkbr6kjYVAOFE7dDpQsbghCnNsPZd7YjZqqZ7n1lR8ab86yq1Ne3S?=
 =?us-ascii?Q?0ITWpjmV4l8Sp6cz0T7ngXwfe8F4wgF24+YA8x4baPgqs+Mx9SadiB03tYwF?=
 =?us-ascii?Q?CQyUrj1qyUWSOZouyRR3c0J8Zb8ODuv7r+FfF7dzXPMXNv2oDKsb7ZeME0J/?=
 =?us-ascii?Q?ObqVJVSS1JZmHHCOrMSeo8/uzoK5SVcL1OIZCeqfSG1ROS6TBeYcbPMIf+MU?=
 =?us-ascii?Q?JC4nEkyCL+hiEk5Y2vPaPV5wA6ul890ejrMGCThcdqU3qHaxMDe/fWQV1FAe?=
 =?us-ascii?Q?D5U33dmZ6xg6ch4hllrIffRI9bV1rR3XCQxcvUSYOLW7OxI03hYuGUKQ+RYc?=
 =?us-ascii?Q?jyWqpc08NAUQHuFkoyPm9/YZDmN1q+k2vEZrCibZREryeMiElwUpi+g/H/ML?=
 =?us-ascii?Q?CzQjETfgb3hm+2pCmbjSc30sK5ZLt8ETzsjpZexlH1J8NzyCpSLt9CollSCc?=
 =?us-ascii?Q?/6no2aB2STSPhP+D0bfkHQC03l4DWMU7FQkXMguW3FyBwVt+SKhSBFh0E8EK?=
 =?us-ascii?Q?q9ZQo+33k45weq65/sDmmQHQg/+TF35mg76XZTlPj/yaRfkVk5fRnrdhRWCZ?=
 =?us-ascii?Q?+5Imct5kD3nVgj0drtTLwKilMSV09ruoDCoDTr6GGuRnKORhQe//cqzyzu6B?=
 =?us-ascii?Q?7btDZaTQ2OI8/e2E50yMY3joFQ0u8NhMFnC0i1D0RN/RE/TLvre8ARNiRxiB?=
 =?us-ascii?Q?XaIcZ08Yl6tR98oqaVNBjbm10jCHngNm5PFE7k7qAkCccaKyGk0+3/I6LZ1m?=
 =?us-ascii?Q?Chq9ei27XBPi/3AL67Z6m1iSHdPDFqXqhTYIX9KcS/jCt1uvwrMXDBv2GWnJ?=
 =?us-ascii?Q?GFozM7kylI3BXb9+F24gpqZ153hdTFy90krhE6kuXNj12TZVUkbGFSEXlp0A?=
 =?us-ascii?Q?0PoVVXbxscJcBSHj7VpdoFhvhBRo8YEB4JK3HAin9bUb1BHuT/YDTry/XQ45?=
 =?us-ascii?Q?ypdN7ro8iEf3HnZO+YJ4kkS3Jg4w3+EeMNREoMrGz44l59yyTx9Ti6s1kv8n?=
 =?us-ascii?Q?3nDtGvBu2hi92wp2NukspcJDhBB6I+10mle5+4b8brSEK586n+X5KEFxqm6f?=
 =?us-ascii?Q?9P7hQcsWEywIcoq+hZK7OxK5GzCzEa5ZOS3N8L/0QSYVJQnWVagu/J4352O+?=
 =?us-ascii?Q?rfue3QH2SBzTgUyH16SAlebHG+Cm6oJNWLEXHCGP9+/vT8meNP01o+ZjM/Qy?=
 =?us-ascii?Q?Xw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1a831e5-3743-40e3-4206-08da60e84dbb
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 13:46:48.3205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T8wX2FvI23gzE4xheoZpEMXTI5b5Q4AQMRuNbzcaYC6+03V4oWbbtR69q+63DKYNBGrkhSK7eTRxArWCBSF3VasMOQv/S3nfXM4UTFAdLUo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2220
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-08_11:2022-07-08,2022-07-08 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207080052
X-Proofpoint-ORIG-GUID: 0to9Gdczqtr3wPngfAxtdf4U6lTYyb6I
X-Proofpoint-GUID: 0to9Gdczqtr3wPngfAxtdf4U6lTYyb6I
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The simple_write_to_buffer() function will return positive/success if it
is able to write a single byte anywhere within the buffer.  However that
potentially leaves a lot of the buffer uninitialized.

In this code it's better to return 0 if the offset is non-zero.  This
code is not written to support partial writes.  And then return -EFAULT
if the buffer is not completely initialized.

Fixes: cfad6425382e ("eeprom: Add IDT 89HPESx EEPROM/CSR driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
v2: In v1, I tried to be fancy and use strndup_user().  That potentially
breaks the user space API.  I cannot test this code so it's better to be
conservative.

 drivers/misc/eeprom/idt_89hpesx.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/eeprom/idt_89hpesx.c b/drivers/misc/eeprom/idt_89hpesx.c
index b0cff4b152da..7f430742ce2b 100644
--- a/drivers/misc/eeprom/idt_89hpesx.c
+++ b/drivers/misc/eeprom/idt_89hpesx.c
@@ -909,14 +909,18 @@ static ssize_t idt_dbgfs_csr_write(struct file *filep, const char __user *ubuf,
 	u32 csraddr, csrval;
 	char *buf;
 
+	if (*offp)
+		return 0;
+
 	/* Copy data from User-space */
 	buf = kmalloc(count + 1, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
-	ret = simple_write_to_buffer(buf, count, offp, ubuf, count);
-	if (ret < 0)
+	if (copy_from_user(buf, ubuf, count)) {
+		ret = -EFAULT;
 		goto free_buf;
+	}
 	buf[count] = 0;
 
 	/* Find position of colon in the buffer */
-- 
2.35.1

