Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A181F4F8F00
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 09:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233848AbiDHGeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 02:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiDHGeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 02:34:15 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D6B2F2F27
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 23:32:12 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2384xY5q014716;
        Fri, 8 Apr 2022 06:32:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=HvAIjh2YUSE20Vo6txCd184KagYEvsC+AolwJpOcnCA=;
 b=Upsw49zZPsAcDDi2DM5Sx9LVZth80AKK1pnotplD4LSHb84Al4nTDNzcsxU5m5WwUHCw
 2a8/S0he8knBhClwdZ/bHtoLeDJiY2nLBFSuQmEC8cyzSFxarhWCI+9iNWW4De1gJu/O
 saROG5K42r1BqhiF2i99PEbrZydZU2VdOBQxWkQJOzV4EsjfSebmF9g2Ws/A4TgQz0kw
 UaGJCKLG4DO6UMuIbixc76HZUYevZRwQ1pg3jE0jJHZcNpsOh+H9oaW2kk3By56R0+nA
 Wf35LEX+chGfYc7pHMWZLp/POI+wYfX3cjbVLvQOWsSOdTFms/nNhvRH6S89fuOyMw1R sg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6ec9wq65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Apr 2022 06:32:01 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2384sXRq013794;
        Fri, 8 Apr 2022 06:32:01 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f97tu8cvb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Apr 2022 06:32:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UqKNWKQDznmIGlp4xjU9bs5EPp7T3rcrdzI2MwvH1WxDU3INZhRZ3YgNzt7wBAb/dbrRJDOF5z2bj7SSDznk+rUvQ/gAjxA2GgGJkG9NfmQYf3azlyW9d9OtcRw7ApbGRHtKED6EVobvwF+pRtnEOMO52i63CPnNk3Tya94jbkfAaKQ6+P0II6Z+HjA11BOLm7kgg9/6sKIpy0RX+N/2RHodDV5sq3Hp845qOMZItmOdjrdt3oVfREVD5DkVI0SJEIbI+25W/+B2zOD7oAsy7NRGUl1L0aAZd4CJ6HDuf9HGhYNsksqFyi7H7dCxAgyl7foLoLAfn9vGi2RDqrKPEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HvAIjh2YUSE20Vo6txCd184KagYEvsC+AolwJpOcnCA=;
 b=EkTNpQC607WVz+KyjeMF7ZzprPhlY5XxJAvn4zIiBu4lyFb4DMX+8D8dhNmRyFcIqWgi3t8tb/daP1CeSeiWLURVfCZUCtIgYzt9UUJ4aoLR7UgcxBssCyMpFDHxt/l9oaCsk+1iaF95zzKe6VW7ajnsSbnbR7kKopaxm8EloqgXkFWKoxUSMrzAtnIDftWmrhDT/3xdI6TueDNfVjoW36xYtPlfY00WEeaUyNnLFxzc1PS11A49BNYEBR5RmwlcZhzfMxSlkljY66d6Lj5jlRWKpks41288hYbFhriZ1cgVT7JIxOyYehsbrZEIxhWPw7nyrtSj9jv/h4TXAxZ30A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HvAIjh2YUSE20Vo6txCd184KagYEvsC+AolwJpOcnCA=;
 b=f88peEYJgp5JFZNk8rQpsa5eJ/C82V67JhAj1O0W11Jfj7gx/TSQhIk1BJxxD6wXS6I6kSbZg4gtX/GGdxC9rihz3AONeUjJWiYvOpIcD4imDAKlSWNtJB/MjBeNIY/28fHXzXql2IVrgBdxI1RAiYQ3YPRp9cOwfMLtIK7AVuM=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB5522.namprd10.prod.outlook.com
 (2603:10b6:303:161::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Fri, 8 Apr
 2022 06:31:59 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5144.022; Fri, 8 Apr 2022
 06:31:59 +0000
Date:   Fri, 8 Apr 2022 09:31:33 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Joe Perches <joe@perches.com>
Cc:     Julia Lawall <julia.lawall@inria.fr>,
        Rebecca Mckeever <remckee0@gmail.com>,
        outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] staging: rtl8192u: replace ternary statement with
 if and assignment
Message-ID: <20220408063133.GP12805@kadam>
References: <cover.1649378587.git.remckee0@gmail.com>
 <36059ec66a2f3d58a8e339aa4f262772eabd3ef0.1649378587.git.remckee0@gmail.com>
 <alpine.DEB.2.22.394.2204080614400.2199@hadrien>
 <20220408055732.GO3293@kadam>
 <34d0ad73f44ff4990f6bee49105ac49bb55352a5.camel@perches.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34d0ad73f44ff4990f6bee49105ac49bb55352a5.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0025.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::18)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a42832a-8791-423d-ba27-08da19297bdf
X-MS-TrafficTypeDiagnostic: CO1PR10MB5522:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB552294765CDAA552FEBB502A8EE99@CO1PR10MB5522.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j9KLKqb65qdXIn4OXSNzoBkF0XWB9rmYEkui2TYZEXAiYiaaShmWqU/MqS//J6Cb+I0v2AQsdU/9H2Ak2g33s9AgkqIErNfhMqa523/BDP9lNW+GqLUB2CRxpoo2p/Rv+NzXlc0jtj5rl+ME9TrgyywoCCfs7QfCVh+3ddPG+ltHwhRtOFZcIDXqm2c5dNEQzk27fsL3TA9NL+bbEmj+w1xiwbmj48DEXh3tCSEOJOp+trnW0i860v8ZvOiACCOkiu9Nab1xF3R6EAyLEz4MMMtkE0eV7hNppZu+FHCys8YQj5Kk2CWFu1kZ4RcNBB3CpAio1DPlBjh+ztIGt0/fHQ+VY2BE3CFDmfoMree6Ze3x2b6Puf8zi84BelU3pxAuozSKUeg4I79dn4i7x1A78swpPANe2Rwe63P8JBDp66MbuTtjryneAXKhNzw0/TxMsETYAs1B8WCTqwUh+tkE0pbp4zd/7WvW2D+4sHswzFjASv4shmotN+fVujHWmOZdvOAROpKzm8CRbRo0HoCJPUKxtipLemzPNEzaf/X5/2tOOG5Z/5XTxcA6T8zoxxY0CYYksFtMjIGbidtENgrhvkqmJ4ClkxxLffkc1qnZNLNqRrMX22+YfFEhuWWEbu0C45AMblV6eIS7a58lxJWWdlJzT1V2mpVJKbeqGNZoR/tc7M8Nt8GaGMdhgqrsaLJjTI53P0feDVBctt2efl6I6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(38350700002)(38100700002)(86362001)(44832011)(2906002)(33656002)(6666004)(6506007)(66556008)(66946007)(8936002)(33716001)(66476007)(8676002)(4326008)(52116002)(9686003)(6916009)(6512007)(54906003)(316002)(508600001)(6486002)(5660300002)(1076003)(186003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ecSGDiklPhu3R8G7OPzyXITzVOXYOnDNHFhMah757eoLwJGpEtMU89tLknf5?=
 =?us-ascii?Q?fVymcket/4OEIIW8ptUzMgQ6hNWnj7GsQBDXsCgRKxImpQ76ZdxTuCWv8sE2?=
 =?us-ascii?Q?EvHvJT8hQlNieDejKSOdx97rleO8HvNlvOvRwT3XqQp3ODI/0yfzuTBoBEDS?=
 =?us-ascii?Q?oCX421La0EEmG9jjf5H4x5SKUceqXLRd2L6iPp/KbErHORP+FeDEqsfwwEGu?=
 =?us-ascii?Q?Sg4qpOIf9URA0t02cYt7SQJZPNhct4Xoc5ZOO5rfJQOEVfDst0ACDps3V0QI?=
 =?us-ascii?Q?TuS7FQDS7E3CqHBGrvS8c6SRngDoPVvTKkUDgIuEdWIP4RY/dgMGIK1OfbUq?=
 =?us-ascii?Q?29HWdwdiqOCabvrbX50Rw6Vt2G/raoNZ74fJI38WFVYdsHxxWiOrdhm3UR4D?=
 =?us-ascii?Q?pOxGujPuQ0C+j3SyuWNjqwJFAZzUjM2l2136UyfXFsATXtnRQIZMm4SeWXwn?=
 =?us-ascii?Q?4+XP1XFWsPJnVOLZJ1fVaih/Upl3JYVUl/T79YEBcNYj3vH5vTfGqhfU476O?=
 =?us-ascii?Q?HsKQHHy/w+KLNJvV6E4HPjVDaxYhcW1DaweZOyeCq2k55MkrJmKjK1xogtoD?=
 =?us-ascii?Q?CkWPPzhOejmUb2ltd2Jt85gM0gV8dWv69TYRPAyE2ccChwMCkLA1uKiTVsVz?=
 =?us-ascii?Q?nTpPcu9bmfaD7DqVmocSGb2D0YDK4qZ9sEVPdg9ukY/eM5KxnorDoOatjeRB?=
 =?us-ascii?Q?KaGAdRe2e7hkmb245LfNuU1YxwxnO+h8fL5Q+wcnmTmMyefgo6sNzDy+fbok?=
 =?us-ascii?Q?cVlsBm5vaMmCxdY/tUUyQYm7dDUfrI8PCZdsuHm4GIzjQT5lB/REpH8QsCNR?=
 =?us-ascii?Q?bNNdRL5UJ5difaIaUMtAvwcQpHkW4BEgjM/xjogaRn/DVdBVMbDGHXRVfpnK?=
 =?us-ascii?Q?/U7vWYSELckrEK++nLhzWSqZzUBFfb3g0c2lyprckmowQtW9kTGyiFWGvdg8?=
 =?us-ascii?Q?UDHjxnmEJPMVRt2CMuU8vU9dOUgmEfKGndAattkfbxcBxnG0XGwRKBu6Sbe3?=
 =?us-ascii?Q?mBr3URISTNlCGgyeOjff0CPaSzsDA2kvYX8wShgDUEXAXrLyLCrgZ+2O+Ytr?=
 =?us-ascii?Q?C0ltDjMZ0bAaQ1FrJztaTBZDnbxiTsjl2p5quz6Hcv2PY130uKnP006lPHpQ?=
 =?us-ascii?Q?pZt2XePEgSQLKaelgsIJbKSRZMvXMaBbJhuI9OOLevy/8mnCdoKJmmXVy8Mb?=
 =?us-ascii?Q?u67le08dA6VCn+exfMunUqfgI83bGObdcm9347R0Sk9Ve/+jDng2wV4w11+n?=
 =?us-ascii?Q?7JYNaZFxOdKY/edb2wVfICH8ZuFqpEGweZJY2THkwd0Op6ix1hzVcNtY6wG+?=
 =?us-ascii?Q?wjI6WuVkH1qhwqgHTo2dv6uszdxXFko6AEXPFqEgHhwlHTfgxxQWXAciNxHk?=
 =?us-ascii?Q?/WPNdTirsF+QCtEicqu/Van+oLdGS3lYjzUbOsA1GDHGguk/zUFrOJLe7vcX?=
 =?us-ascii?Q?9gOwxZOlYepZLFWvzvjKTNUYZQks4UM8omBfw5MSTBmoh9BxV19MW2iFiDsi?=
 =?us-ascii?Q?fHwxdepbyDQD4Q7bOXJsdXEK/RP29aLV2oI7niYtMH4eFbRxgtU4wcabLPiX?=
 =?us-ascii?Q?AlufooUmafrGTzhQNFOCO+Yr7CRv3AcQc55Ex0+zbkAuKjA5rsiBq1pbVEOO?=
 =?us-ascii?Q?XARArjgCkpg3eBWrc09cU3vo8U+u0CQGTwI1EliuT5Yrmp3cVClWrliWEDva?=
 =?us-ascii?Q?BzVXBrPXHn781c280oh4cbfzbOY98VM1666tXFEiPZYTiyxyraa0TiGWmuZD?=
 =?us-ascii?Q?klFl+cPXfdlfCobtmTJ8pvje722U8Fc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a42832a-8791-423d-ba27-08da19297bdf
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 06:31:59.0209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o0VZzN1X3rVFGT2bMHfPHtGf/PiO2aEOZRE+AsTjDj0pmZOf9PhS8b8ye1SjuyhcaIDlSsMcsHRdMQdsXoOyGdt6/EaQTINaHOEqRlwGsrI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB5522
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-07_01:2022-04-07,2022-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=891 malwarescore=0
 mlxscore=0 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204070064
X-Proofpoint-GUID: c33nNitzHFYa1iQdGikKXAvRQq7E1iBg
X-Proofpoint-ORIG-GUID: c33nNitzHFYa1iQdGikKXAvRQq7E1iBg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 11:14:51PM -0700, Joe Perches wrote:
> On Fri, 2022-04-08 at 08:57 +0300, Dan Carpenter wrote:
> > On Fri, Apr 08, 2022 at 06:15:14AM +0200, Julia Lawall wrote:
> > > On Thu, 7 Apr 2022, Rebecca Mckeever wrote:
> > > 
> > > > Replace ternary statement with an if statement followed by an assignment
> > > > to increase readability and make error handling more obvious.
> > > > Found with minmax coccinelle script.
> []
> > > > diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
> []
> > > > @@ -470,7 +470,9 @@ int ieee80211_wx_get_encode(struct ieee80211_device *ieee,
> > > >  		return 0;
> > > >  	}
> > > >  	len = crypt->ops->get_key(keybuf, SCM_KEY_LEN, NULL, crypt->priv);
> > > > -	erq->length = (len >= 0 ? len : 0);
> > > > +	if (len < 0)
> > > > +		len = 0;
> > > > +	erq->length = len;
> > > 
> > > Maybe you could use max here?
> > 
> > Initially Rebecca did use max() but I NAKed it.  It's really not less
> > readable.  Better to handle the error explicitly.  Keep the error path
> > indented two tabs.  Separate from the success path.
> 
> A comment would be useful as it's not obvious it's an 'error' path.
> One has to read all 3 get_key functions to determine that.
> 

I'm so confused.  Negative error codes are the common case in the
kernel.  We don't need to comment it.

Obviously in an ideal world the get_key() functions would return -EINVAL
instead of -1...

regards,
dan carpenter

