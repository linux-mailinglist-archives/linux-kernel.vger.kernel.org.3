Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290B8508F18
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 20:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345106AbiDTSMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 14:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344942AbiDTSM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 14:12:28 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65A041638
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 11:09:40 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23KGFkMB009092;
        Wed, 20 Apr 2022 18:09:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2021-07-09;
 bh=6uX3hYIHlsEPjBW2Pdf5MDqbv1p0XWmTCU4NelSr+l8=;
 b=z3MKkFA6ZCY3JFkFgMoMuVd/Cjxe2Y/7R9/6dGmLdlFL+cDIdAs0mrcS9eheGO0PrnQ4
 n3B5FE29mwBtkKIF65WEGlvP6gJb7ne9uenXJyd2q+LRl4mEPIlMY3tTrIHCUuOBDLKx
 rGZoWxHFVLCzLpeL1nN1eHN1hb0y0vI9q4/f0BnHy957SVDpxDtH5OP6CE0ExjbuuBnS
 3WPrhYzNQGndHebSvLC/WxJxHVsRqKFE95he/eqTLjM8QVgRkCkLhGQ8ORXLnPWgSaO7
 jExmFnYriB5uhh6s43NZnzx//Lop0364x+BeUjwEUppkslkUl8oLH0b0cWhP6TgQ+6qz IQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffmk2sx4q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 18:09:35 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23KI0jCN018924;
        Wed, 20 Apr 2022 18:09:30 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2047.outbound.protection.outlook.com [104.47.73.47])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3ffm880xqt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 18:09:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dEi8JYP/Lr6JhZ5mg1jKvfCfLQp/cuuuBnxoUkwKNHvcxl/sNtCCpayEhoGlrnhD8IlYuFg+OqXRZ6w04ZhpphuJ6/JsWiEhyU7gwtZVsmDtRs0jXG0ju1eLEXVN1K/4WlOLP9UuQnuflUlsO38bTcNU3jZfo7HGJNXf+xKOIt5jbWVnQhEMenOPmtDfXfA4BuH3FLahmU8pMUemWrszyhgRHtWnRwEQcHO5aRGTzuyhyQVdBNUU3IUTLhC0ai030idsWfYatTIz43WWrwdHNuUueAEtOKIFtIcCgf/znlkgmFE0jphwTETxMwFrGxkj5CupUbNNOgPfQNuMf98SQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rm+Tf1S4PeuhjR71hbjUdFGBC1TL7DWUYOzMcL6w2XI=;
 b=RBWuic+0xOCMPp6PIesxcnqDqdghHETIdNwgoDgMDj5E2naBuwANYRIEQYMGAfvmQgjDrsmOq139SofwMc2me1CWbeJLYdNFtQFx6Y4zuBsPFx5wbgWQzyRL3ykgvGJ3tR+701QmrB/TEXnTLc4/qxiDeUzBkUJSa6CHhkT4pTFzIRurGN9iT+TClXN+0G+S6tVE/AruuChyrKRmWX14Ilj8JvKVhra+HyGL6KWwTeZ2AfJD99t/BAejzMcKfyrv02bvJGC3rzg84s2wF70td/hMuNZbkAfTXnKEfeZ6SXcGaJYfenTIFiowcGOzeXhwhtq9rzvuWQF6JbEXbZ1P9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rm+Tf1S4PeuhjR71hbjUdFGBC1TL7DWUYOzMcL6w2XI=;
 b=wmcW267/33XKgMQ1KYZBZ69uO/E020DLoK8XPH/Ym6KCC7IJoo3b5VDgdcbTUzcY8pf4lz9NpUtlNHZF2KX+/qbYKOuk3ejtNk0tUMdvGgi77fodthh5Pjmqmy6mur+9u/Taj+5Cuh69nyt0ekB1DokG6y9q4K+wAXTEKILlzgU=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MN2PR10MB3759.namprd10.prod.outlook.com
 (2603:10b6:208:185::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 18:09:28 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5164.025; Wed, 20 Apr 2022
 18:09:28 +0000
Date:   Wed, 20 Apr 2022 21:09:03 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev, Rebecca Mckeever <remckee0@gmail.com>
Subject: Re: [PATCH] staging: rtl8192u: change get_key functions to return 0
 instead of -1
Message-ID: <20220420180902.GJ2951@kadam>
References: <Yl/7QPKXer7YtXOs@bertie>
 <3183776.G96rZvMJ2N@leap>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3183776.G96rZvMJ2N@leap>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0020.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::20)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ccd8945d-1bd9-4cd0-9aa4-08da22f8e90a
X-MS-TrafficTypeDiagnostic: MN2PR10MB3759:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB37594BCEC53A5C4D994DDA7A8EF59@MN2PR10MB3759.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yczi6jg9p+zso6CwD5vbmQMg3i1jziQxnqY1wPRhYzgHkGG0j5gObjyRXCVubyzN6qgKRRsZY4aap0P6fGjEIrTtsZhmp/1y6ws+L09im2whTeu2SjSAsoLSYrJ6J14TlmVKWQsVr5NnW8HtXboNHP4zlQLf7REmBNcs4iXZfCToXL8N0wWEIhph3JxrM2fAEg9A9QnWoxN6uWzOamfaKaJrGmamrpcS237lZFq68S3OOtTNGBK4Mlhinx6TmNXlFtCy9abRN48KsOAoC504dW2lgRMincWR/s8B1ht17hSv5GkBP1PlPWccC1djptMjUMFRsFVU57xeoxF9rruJGlE475Q0ro0I/uX8vCPn0kMzSwIM/5R1tcYOk2LS0iG6bOFjBpxOhV8xrxAMWHz+UA/Dlo40mjzP6fTspNeDkPBnbDdFI9ecQdkDzt5T7N9sBlXGU6iOu4hWznlsWYtba2FM5+3WBhoL9M5Ua1L7uc230mji3XiSztMa/rPqrsEE1tHU3ip0F6K9nJEmTrp2f9dS5tDjz1dZxVoRjnGzBPWhGxFO0U4TbLjbytLBE0Fn+XGJSqZe4GyJOzcmZCP6s4eVKwaKGDvEhF8OSr4/mm/u3W63sDRTh67b82IJoSxXLmJWDdGjt52Qt3XRHMBY+gfQBXzs4Yr9OKifQGYwdAD82OTm7Gostbq1Q2UL8l2HoGiDzYx1laq9iBleOxE1AA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(38100700002)(186003)(66476007)(66946007)(26005)(44832011)(83380400001)(86362001)(6666004)(52116002)(5660300002)(6916009)(2906002)(1076003)(9686003)(6506007)(54906003)(6512007)(38350700002)(316002)(66556008)(6486002)(8936002)(8676002)(4326008)(33716001)(508600001)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?TfOEE5hMpgEVJ/RovWuF2Z64mOYtTbvdQJWPPD4tmC04hdRCq1ALZu0jzB?=
 =?iso-8859-1?Q?8XWOFEecrOUggEwFf6uxCAzBkDDOBmn/ToHLRO+o5Jcu27kwJtHPCY/N2Q?=
 =?iso-8859-1?Q?eRcMynLDKsA8FciWzDUxpG2OlymwGFXV+7Ap/MtGbOsmy0vJn1PReXvqqX?=
 =?iso-8859-1?Q?Z9924lKd+ozCI8U36eTvcRetCUEo4qpG6iSs419/BS1MIoOrTDFMFEWBFs?=
 =?iso-8859-1?Q?8CuWqCKZ1TpvC86uaKyp6OnJvmIuAVOsQL2Afeo6NTVLL+24pzzAvHd6r2?=
 =?iso-8859-1?Q?unV6mmhJ/xvNrBmRKOwIFl0SV36dKiv37z/rkdbXo53mu+tt6wAreEPsjx?=
 =?iso-8859-1?Q?jGDuf1U3OV6mjtQpgWBOnddPMbDX/0rgOR4Um3nsh/FbARxfeO3E6r8cIJ?=
 =?iso-8859-1?Q?QW0qn24BzFb6f+dKcWeibjlRbgGQpoYlV2LhODjDqmDBzN3Qwm4iQBO66y?=
 =?iso-8859-1?Q?LgsurUSEziSCKgJsW8bAo1ZN/VrGVI/YamoDNdRS7AxlPTLWqZ7hZg1dZJ?=
 =?iso-8859-1?Q?soFwhR5tK/c7GklMp9uhWvJ/79E44kYVglpwy8UWAhfDPfJvBvE5k2IfH2?=
 =?iso-8859-1?Q?mec3VArh8TPtUdPoZHP6qbjg6UuZFi8MlD7ORztKzV+bcUVBIDf16rfXBv?=
 =?iso-8859-1?Q?CRZvA9iWcsY5+gK1xc7JjCYpqv7sTTsXQJziS1WGXe3Bk372IXqmXa/fIi?=
 =?iso-8859-1?Q?8dmQp4QnG/bNWTZV+ugUZGDhIapsiq0BzsXOWgb/KV0rm3BiOD+EzCH148?=
 =?iso-8859-1?Q?Xb5ecj/Quw5T+sbNIxraeu07Fl2ApO/yRSajuEB0l2gIRSAcLw6jhDwbUK?=
 =?iso-8859-1?Q?EeKAKiWPm4lAVjMZ0uegHKpHHsu71kOGjS2EVPyzApwXk+aFYGGrmW0rPI?=
 =?iso-8859-1?Q?7jQIMwTIdte1tNgdhlYBBHAgNAK7N31JqqbOnxi7e9wjJh0qpnlqGDR+/n?=
 =?iso-8859-1?Q?OpS8w+saumSiyee+Iqga59GwSE/O1WarUmXnY4PnRx4FKuiwzbaSt9Ywg0?=
 =?iso-8859-1?Q?+qn0u/kKHNgudpB9eySXSmKi79OxWVhOJKKFZZDR0M9ZjIxNuAs1Bo2YSa?=
 =?iso-8859-1?Q?eJdR4J80bu+z0E4rC5ARVPyUETvA9KrDi70WrGHfFfAPWkC9SEYgpZpUSc?=
 =?iso-8859-1?Q?/CGXJaHn9bqt6UlAcL+NN70gajUjd888nBzMs9OKi46A+qcwBR+zE5TFgp?=
 =?iso-8859-1?Q?9aphf+W9r85gSDrmQ00gNvIQi3wLPG8BXq96UsDG9Necin64wc0NdpGO2h?=
 =?iso-8859-1?Q?PK2IL/Pa8NhC6Fr1E8qmiGhNkEU8G4PPFvc/Z50iCFt201LMj/2lgpFq8W?=
 =?iso-8859-1?Q?PR0Kij3P2aWnQjnUx9IvRMIerGDcBI6A79aDZZgrZsyMH0diBRoVnb/eqY?=
 =?iso-8859-1?Q?uKPK2CZ3C3RyNev1JhtOh8MfW/JdllHDikHm5TLyxxn87yHEUo7WZdynQC?=
 =?iso-8859-1?Q?HbqxVtkntjct3kyzER7KEMjezinbIHQN7//q22u9zspUbnbXFBxtUmZITD?=
 =?iso-8859-1?Q?iFX3L9OzVBJBxlQWChh8y2cS7lEsjB9xINAiTZsDqxb5CGj36iQib9Sf9Q?=
 =?iso-8859-1?Q?Ux3SMW45i/6dh8S2OoTjArBh/4GSxBWViUk1LNI7JzQDKJKWBSRTZG6364?=
 =?iso-8859-1?Q?3cMeOh0R86xty70HawfzNj82v6ru/SdJAERHKW0m/+wBLhd0C0F6zOTH6y?=
 =?iso-8859-1?Q?EE7k/9YKA+iwziUgCf2p6dJMDobm8M2BIfC1XNmdWjxmprfDQHwbG+Vlt/?=
 =?iso-8859-1?Q?9qLgswOibhaRMbaenNI1DYLIw2Bk/VnwT6lmXlWwgbncCpjzmqHFjs/ZEu?=
 =?iso-8859-1?Q?v2oalMrO4JHLrCZFzo93m7zG2UQd3EM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd8945d-1bd9-4cd0-9aa4-08da22f8e90a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 18:09:28.5710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QIxi2uFqOsqrADK/Ivz8PJgadhBo7c6Ou/bSICx/iHPwYO9ktBNYBO6BwdhTDnEHsf287mcIsfHzDo2C0yyoFy1faqKK7slHcZ/5zQXaMTk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3759
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-20_05:2022-04-20,2022-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204200107
X-Proofpoint-GUID: zU-6uYvAcY0R0T_5-BTaLJ4PasXGZ6WB
X-Proofpoint-ORIG-GUID: zU-6uYvAcY0R0T_5-BTaLJ4PasXGZ6WB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 04:52:36PM +0200, Fabio M. De Francesco wrote:
> On mercoledì 20 aprile 2022 14:23:28 CEST Rebecca Mckeever wrote:
> > Currently, these three get_key functions return -1 when the provided len
> > value is less a specific key length value, which can result in buffer
> > overflow depending on how the returned value is used. These functions are
> > used in three places in ieee80211/ieee80211_wx.c:
> > 
> >   ieee80211_wx_get_encode() :
> >     The behavior of this function will be unchanged.
> > 
> >   ieee80211_wx_get_encode_ext() :
> >     The result of the get_key function is written to ext->key_len,
> >     resulting in a buffer overflow if the result is negative.
> > 
> >   ieee80211_wx_set_encode() :
> >     The behavior of this function will change. When len is less than the
> >     key length value, it will set a default key of all 0.
> > 
> > Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
> > ---
> >  drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c | 2 +-
> >  drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c | 2 +-
> >  drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_wep.c  | 2 +-
> >  3 files changed, 3 insertions(+), 3 deletions(-)
>
> I was not able to find the message where Dan suggested this solution. 
> However it looks that we actually have problems in those callers when they 
> get '-1' as the return code.
> 
> I didn't look at the code with much attention but I think that returning 
> '0' to signal errors is not so good.
> 
> If I'm not missing something from the context, I'd rather return '-EINVAL' 
> and change the callers to check for this specific error that would signal 
> we have "len less than a specific len value". If so, act in accordance to 
> the returned -EINVAL.
> 
> For example, in a caller you may test:
> 
> if (ext->key_len == -EINVAL || <some other test, if required>)
>         <error path>
> <success path>

These are valid questions.

Ideally the errors wouldn't happen.  Maybe they don't happen?

The error handling is copied from ieee80211_wx_get_encode_ext().  An all
zero password (rot13 security) is better than plaintext.  So this is a
conservative fix which potentially fixes some memory corruption and
doesn't break anything.

A more extensive fix would require someone who understands the code
better or can test it.

regards,
dan carpenter
