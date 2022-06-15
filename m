Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E26054C3A7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 10:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245032AbiFOIhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 04:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242935AbiFOIhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 04:37:45 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73499FDA
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 01:37:43 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25F72Nlm002108;
        Wed, 15 Jun 2022 08:37:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=LNzAa98DnaKBtFYIsPGYdGy5Ndzf06TeimatZRTVxFQ=;
 b=qcxLSQgRTvjwa8+U/3ioiifqfsmqepRHS1gMEFeDWKPW5Gnpm3Z6PoH1c1xRtFjHAumV
 u+NrGR/J1BrJ/+FFqnfB6h1LcUfXCbVb5kREPaQY1Q0KAZQt573PoX2esa/UK25hQODN
 aDKvOPnIBzVs75mlT62iOHyGCu3qRDQREvDhkgq2Gmu2dLfwq1MlsdaCndwvwFPxTsyp
 0hgNXeOLfGi9oKtdyAenHQIZbpghXmh7tM3VmMIpWpshMFElUOg/gDLhwswDhWtAHlEw
 iQlYYKQVLAfy9oCTyyHuGJLgEsOAwJ175yuGyPMGStP/B4JAOWsQkWUkNdHKcn+N/Ulg Eg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmhfcqxer-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jun 2022 08:37:37 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25F8VaBe023298;
        Wed, 15 Jun 2022 08:37:36 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gpqwasfa4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jun 2022 08:37:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DtOxK0u2MNP8T3/9k/KGvrXGXTkHOqyXLUPgQvOyESSoBaUHTmkTiCSXaonxhzPsIoTEjdNxuwisyLLXxVdnVG6GnIUAUfIwmLjhfeQEixx7zMRVrJ2FEzhxSy7wRcl8+Mmb1AS6r9OU77eHK0h5uJKaL8hr5u8Fct8Rf6jVmadq/bAAE0yADuiH9o1P0soeoIaksc5HwyMGZaRegiDTYeFVD2eMN8LFA5WAAZ8Gh/Wd1W5eyt4J+8xc964ypLv2WfWWaCrkIdr9ipD7sRaTAbHflgrGLIA1u4Rttzj4y1Y201zq201vtorr0rcOOGxC90cuHJ7WYvT+1OZ79gcDqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LNzAa98DnaKBtFYIsPGYdGy5Ndzf06TeimatZRTVxFQ=;
 b=PeCj5rlCTxPgJkCfImNaIKB2E/u7giJevQlHAb8RJ0fy412s0gYXe48FJIPgigiVYW7cw6/iSiXANn8VKuJMudG6TkWkqnBIm+bEU/lv3vaxhhFONOY50Q5Lm0jlUDnz53GoM9pek6jYI6TsDCmSISwAszPegrYsFthYyFjugOQUHwdCGCA4/hvaNseursFYWWpzgEVWpmlA6u/UDW8YH6Im6Pawg8Oz9cReh0piBqQhC767kNcQAlqfhIOPA4u6IoR0XJBwNVsKsfiaKxK+HwXIBOWKCMZU5m0nz5mrlKstbZsRqOfyrSmd8Mt9K6cpnQyYVaTtfRg9ILzqFYOARw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LNzAa98DnaKBtFYIsPGYdGy5Ndzf06TeimatZRTVxFQ=;
 b=TF1dfl0EmOyQstrLhFlKnvOsEIYr68niStH1rMmxWhS/bp5y9nejIevWoBc6BKfASTo14FY/36UIceID59mVDLk4asEl9Yad9LLcr07jq6RXMVgDSBTW//N8n8yNPYuIYQcKAa6c6rFRfVvQihUKWb0pUN7iJ8UMVi6MwyS1+oA=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1840.namprd10.prod.outlook.com
 (2603:10b6:300:10b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15; Wed, 15 Jun
 2022 08:37:34 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5332.020; Wed, 15 Jun 2022
 08:37:34 +0000
Date:   Wed, 15 Jun 2022 11:37:15 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     daniel watson <ozzloy@challenge-bot.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] call rtw_IOL_append_*_cmd directly
Message-ID: <20220615083715.GM2146@kadam>
References: <cover.1655249804.git.ozzloy@challenge-bot.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1655249804.git.ozzloy@challenge-bot.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0029.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::17)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c72117ba-e004-44d1-fa9a-08da4eaa4afd
X-MS-TrafficTypeDiagnostic: MWHPR10MB1840:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB184089355C4667503EFAE2388EAD9@MWHPR10MB1840.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ciCsc1qc17AOyZD1TtsSTQZ7Bt/jNkB4gpAcCITLGZYIPoCUT41ZseWlRC/1DimJwLPUFUz7WaJKOJaJz8mfJjkCnC0ftf0quFxsn4cQyxE9GoGmdGpKFvvG2fE/HFqA9/QLvZjymqAdxNmaP0MEfPtqNf+YZ8TZtqEPF3rzkHKNvS9TQawrVE9W4LaRTymBiDUQZ78F8fdY8Jyl8vSXDjxe3YbegzS7VLj9GKCY/0ovmMLRS9rSLQsD+Mi3T4AHT5MijCRYeznxYD9nb1UJ4z8GUrOg95sJSVaVZvgw0bxJwgmsBsbbgn8ge0/LQ8lRR/zD6C+L+oJUH0vEai1uh3UWTzIFKKG/RK6RCiQP5VW/zVweEY3nWoUPKTiA/uvS6qdfKtKiP+N34F+Ax2weVMkG5X3abHKwiNBPDw/gxTBHnmjJdSgywQ1Xppd234DiZ4A8/HHsd/WpugpYZqBdKtzPgKkVoYfRSn16Opmw2dGNYsLGmQo56h0pPakKNr2HIkog3WNBBqGS18G6mQQWIOqOpStR9DX8cvK4hLnzTsEIQZlbG0ebrsNqQ48/KnGErjkJ6JkjV5SXla0RHTOihYYau3jJj5PQfJ7FzC1fGo3NnBvtvoy1odz45gUY6TjN5LiLfnchypsqux/e+ktEC57BFe3dTMYhmlDtCGBBCsQw3LsX+926X+A4Lk+RlcccGapqOcmiJnRzq0D6gWhVdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(186003)(4744005)(66476007)(8936002)(5660300002)(508600001)(6486002)(2906002)(33656002)(44832011)(6506007)(66946007)(6916009)(52116002)(316002)(8676002)(54906003)(4326008)(86362001)(33716001)(38100700002)(6666004)(66556008)(9686003)(1076003)(26005)(6512007)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nBb3Qb73I8lNBPfy3c4p6LoEbsf+ibMi/L6m1UDNEyEIa64APSqBSKIFdrZ0?=
 =?us-ascii?Q?LkRwtcb1smkO4M2VQGxmI61UsFTeWzVTMEVcFMD8pt/1Vj6GoAPQ6bOUQgGr?=
 =?us-ascii?Q?/4qOB1NANrGLbl5tYcAWOcYxT3RQOR0Hd+W6z4WuDOyW8T3ZcIodazLN1whp?=
 =?us-ascii?Q?KoOVOlgFTjOeFBCFBtrVw6CdN1M2BBgxDQYVHbwcgjpVT6hSDMme4UC+qzF5?=
 =?us-ascii?Q?QPiYdoQLTXn97ipvERqIqNfQ8heFP5KvrtJ075WL70QP6YecOH6lLPcRsnDR?=
 =?us-ascii?Q?jrkPSkcgq9MYizIJWx+1EmohxIQePi/dWStEDXEhBP5M7BBD/ZRyfD3eLI3r?=
 =?us-ascii?Q?ly5hxIaQMd9S2l9D7n0GBif5YLro2hZBI6ei/Amn/XXrDPI7PrPeeoeqUgTW?=
 =?us-ascii?Q?7o91TkY5+Y7xseEt13+x66Da1pb4vxoF8UFDTsiCmPr0up8g+qsj7y1T7LSB?=
 =?us-ascii?Q?75/QQgn4doDb5/drwnPCMcVUSnv3JhdfUIYPgpoYzwTdc84uIjmHlWOm3GxL?=
 =?us-ascii?Q?mbuZKSAV5HpyO9HQJUYQhTIH4clVxqMjLOJ1Blk7Om+L5+snJTeS5ABOYOIX?=
 =?us-ascii?Q?z8ofJgwRN4W0qfqYKStjP5I5PFDhvNfZa99fzMKEh6lz2Bc9cp6o+VCeJZDT?=
 =?us-ascii?Q?ogASGhs+fvr7yVBXJgMw0tQRfzgAgS1dFlRfiNh6htchGjLYDhobhsts4cen?=
 =?us-ascii?Q?+54uYpPC1oJYf50dit8g3KaRdwHtu9yOvkmoZDz7csqiZa4/fxsd8Pmwu6vE?=
 =?us-ascii?Q?cH+VXAyO5ZvhZE2FxjOMxxViEhWK+LrswOc+xrGM65vq9o4vlZAtoox6IBpK?=
 =?us-ascii?Q?EehCb6nvMArSF5ZtiEnRhXPhPbo+Xf6QhRc68UgWSxmUPGU5IAS4yhKn5LFB?=
 =?us-ascii?Q?5k8Sig1Eb/Lyt4GRyN+EAxDnkiQbUnEMkkkoYWEXaPrx348cQC15dVYgMK0q?=
 =?us-ascii?Q?bbXg1xlRFl876yJugqJ1+ZRnQFPJKX9AuEq2Lt+t8jjVIUJzGQd8HRLe/vEE?=
 =?us-ascii?Q?ra9OuC7gPhWMwZgHSgKBBp2KpG1NWbEtvh7WoSepSfNah2S4iFPJoyFdO2Dl?=
 =?us-ascii?Q?ptD92J+cwZLDien0gm7uJpUOz25Y5Qm5lmBgZSuaV9DO7OkYM1Ne3Jy3njaJ?=
 =?us-ascii?Q?eLqNmb3YVLMNlNnnSNM2gRYUvxWrDtwrDscA3dQ1T1Kp3ta1pw01jCcIIMxj?=
 =?us-ascii?Q?WsADP6lw7mEYhFSksMNoePHdDlMQeVZg8PhDqxPhysxcgHAcPP5are5QGpDT?=
 =?us-ascii?Q?Gnd0uEDJrj+3xo2cdgBayCvd1vo13zIlzINxy2XHRacayu3nb9b4iQDqjH72?=
 =?us-ascii?Q?UpF3sFaV4sERl5FU3JLh+R1+orHfS8P7XPvzGfTwzR4z6nwoQ8MzjojHyMbd?=
 =?us-ascii?Q?eyH18wpklGlm2LsJhzHJA8q2TBZ6d2qJfqQDYdwsfrDFFx1vuPBImlvTU+aZ?=
 =?us-ascii?Q?V5jKFvOkxvUEBWqEN+kdjCrcLgpualUlx7G6hm1fbOD2pV9jnUyyS1Hi/kZl?=
 =?us-ascii?Q?WMKn0KN4WLVgRIWx8R/xz4HZrMl9SmLqjjq+lZg8tmI7bwq7DpWq0vOtRsRr?=
 =?us-ascii?Q?vCMj7X/hofv+GvdFJ+n8ziTzE3s0K+uXkGJ3cxkrqWcnGyukv6hutsMWgjx7?=
 =?us-ascii?Q?CyY1/eSS+xvM5iYI1WX5QIX/gCfEgu6csPplpqS9ecTpYUbXq6BEoRfrXMes?=
 =?us-ascii?Q?IlUMKynTVfXR0+X4u/FcKuCwpc8Tm8BHu7lfwgTKv1z/AsrqDxV0Rzs+QeMx?=
 =?us-ascii?Q?Fajtsmo2b6sgiG5RgDz6V19Ljf6ML/c=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c72117ba-e004-44d1-fa9a-08da4eaa4afd
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 08:37:33.9505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tFbLXE8OpiAT0ffzZo8DvYsyVGXAZcoFTuOga5cvTx147QbV3Hn1uTlpYAs9RAZnwyArUBxlKmeDQIRm1nwocQy1QRmbzzFWVJAI0JNE+fc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1840
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-15_03:2022-06-13,2022-06-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 mlxlogscore=923 phishscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206150031
X-Proofpoint-ORIG-GUID: wCQXGPuKHmXTpFAVA6ro7Wd8-pyYVQYl
X-Proofpoint-GUID: wCQXGPuKHmXTpFAVA6ro7Wd8-pyYVQYl
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 05:49:24PM -0700, daniel watson wrote:
> From: Daniel Watson <ozzloy@challenge-bot.com>
> 
> This patchset calls the rtw_IOL_append_*_cmd group of functions
> directly and removes the #define wrappers.
> 
> Daniel Watson (4):
>   staging: r8188eu: call rtw_IOL_append_WB_cmd directly
>   staging: r8188eu: call rtw_IOL_append_WW_cmd directly
>   staging: r8188eu: call rtw_IOL_append_WD_cmd directly
>   staging: r8188eu: call rtw_IOL_append_WRF_cmd directly
> 

Looks good, thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter
