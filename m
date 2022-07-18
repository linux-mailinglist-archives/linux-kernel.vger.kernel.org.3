Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D74578285
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 14:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234716AbiGRMl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 08:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232964AbiGRMl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 08:41:56 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5129660DC
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 05:41:55 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26IB47iI031625;
        Mon, 18 Jul 2022 12:41:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=5Fg23OPZePcH6kCL+kbGVytEZ4QLvaek3u6ZwrVP0Kg=;
 b=Fs9dp5wfOEjjoAKyzwxMvtCqkZtiVcGLWVJRVSoOvzN6RGKRKtvs/D5NoXSVB5xeBZIs
 iZ1s8wCRDEXhZipL5u0bpH7esdXP4KEg8g12dtcI0vpMvpjNb26O3XwaoX67kQKXoyWL
 lhChVp/ASgXcbuyO98o3gqvjSyjJ32zLWDmrO5xQYweby1xwBaNnvl2gHp18wuMZZ+Un
 vcbl5UMwJmR2xJ+KCostn0JYiZW2jFp2a3YYihGXqGUrQGalEXOx//EQe8bq/VHTfTsV
 N83BI2q+A9MAspfRz6fEeSumhI62gzO/SQpedBrvEHRQ4RTmYTQYYYwWeQEMwj+FGAW2 xQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkrc34ym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jul 2022 12:41:50 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26ICOv9Y006707;
        Mon, 18 Jul 2022 12:41:49 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1gfhj33-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jul 2022 12:41:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EEXNRU0MDfB3mKsrV0JmfzQB9E/RgUhCAU3fIjtise88ypFJ9kqZN55u6yDUdUYgBNOtUs+wsAW6636GUs4obWi5CL9A7aREBvH4NAKGNHyss5rgFtpY0MuFrNdACuOjNr5mMTSUKoFLCmGl3dBrlP4JF9y0x7eRa7M7jMGVAhsUb5+lBJj1huT2wZjCy/R/sHaPQPy92yoVeiWEIIPJv5E2oFH9Cvg8DLgoQnanUH1PqrWBqzFqm5UgZgCEiRPK13K2d01fIFkrZQHl5E9wrkY8bqi/FUJuysgcOwqxtxsrMuuICKiaOAycSASgCH/UCOLgKMbYyfWwlsk8wSNPGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Fg23OPZePcH6kCL+kbGVytEZ4QLvaek3u6ZwrVP0Kg=;
 b=lKt/oZv/VoUr1+gc0AHn/czhyADwZdWnJLp4jfsFW59xgWjD7vNzxv7RpRSREbi3c6sJmc1nouaCn4INGPtYm4XGITc2gFCPmuSjrDNzxI5Qaywt9bCTy+pzuUOE8ajFkI47ja5+RWxtrY1JDlh8fHf7UM0XN3MkwMXXXpVUuGJ3nfk3m0YXOK1vMTk8tjxZu0Gg3BMizqOk89GVAITi025mhKLk8Unx9UB2LaKIHBGoL0U3yg9cVJS1zkLd2QNQ+o6s7VjzXOGWhXbxDnsHBAUOpDipoGZdW3OZbUuSrFBvdKxwGp+pMS3tgv3j5B+e5sR7NafpFZb9VVVxjRYFCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Fg23OPZePcH6kCL+kbGVytEZ4QLvaek3u6ZwrVP0Kg=;
 b=fYDPLgA0nBVvwobMOYKqDQcYTLlZLSZZy2QOIoNLvQ6exP1T6Zmf1MtYct8jKHRbWNXvcG9Yc9qPvslsX2DZfGoi31iRtMyZdBnwGKwcuc/SBa+6cEkewSq69i57z/bVge8zTIuxtiA3eBdwMZLvglpqA8wxsYpLmyePEVACyVg=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BLAPR10MB5201.namprd10.prod.outlook.com
 (2603:10b6:208:332::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Mon, 18 Jul
 2022 12:41:47 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 12:41:47 +0000
Date:   Mon, 18 Jul 2022 15:41:37 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] staging: vt6655: Replace MACvReceive1 with function
 vt6655_mac_dma_ctl
Message-ID: <20220718124136.GE2338@kadam>
References: <cover.1658094708.git.philipp.g.hortmann@gmail.com>
 <c433e54f0fae051fc8ba9050aa094d6f7141e8d4.1658094708.git.philipp.g.hortmann@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c433e54f0fae051fc8ba9050aa094d6f7141e8d4.1658094708.git.philipp.g.hortmann@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0157.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:1::20) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eed5413d-2fa2-4726-36c4-08da68bae012
X-MS-TrafficTypeDiagnostic: BLAPR10MB5201:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EmG8GageaNjlZvaqUQ8juH160IBCriQUU/OsUaUzHBouOuWwJy5ylQrlS67yT5IRWS/fkp0VBPwrWz/9pwiZlJ9izMsiUve4H6EyUQy461Y5xQBsg9+kUL8y9xcx9UPOsg/bcOg+46NJJ+epZy/mRmyBExNJ5x+pu8FKfPfMWN0l5VzEmYi7KhX+yNQ2mwKEwda/mR9fLJ5iP2wsUyK1UGLW92unnNiPcIVwKMbJV5uKNtQR7M+SGzjGuuU8ru4LcHq1AeBZHEBUV/JhtLOlUt7Zx87Hy1ZrBUY7BRpiHUPr8U9W5qzgZ75tkLGVq+17jKEX58KoA2Ju/5hpdtBhUuNEqXW33TE0WL3F3cGsyfI9WqMcKRwRfYxaABSFnSgliES6Fv7UkLtLoFKsAWsyImYx6Vv0I+JoJoNQxurlt7vhcZcN9Eyxdv6z1/VpLjDXwvwGr63S30fVrK3ZYaZcVR/oLCa+gnOCP89FHj7Z+uf5uWftRHY8sSt8Zr+IhUuNHt5vRa6oT4UCes9ALldo2LzmdWCDPfUM4APFsJz3+FXCdcCoU/ox0510Bug4uAp1mUWiLKhm1GV/Ch4Gjl9MQiyKHGSxAsWPpMxVKvYPvyjUZ1SN2YW73BgrcuRtR33IWB+x+/jVlCLPipCE/+doMWvORHG1FIEFDy96UTz7e9yjuw1Yj3r9apkyVX8km6QqRJbdOmXv8v6LzQv8KwUDMq1z3wfLD+9Om8EMaZgXJHUwvSryoLJoYJbxfB+YYzJr8TwzKuNda/Us7ZlJ8F2CnqA6DB8vtgOCDP7krqsoZxxYQGyoGAuyzu/2Mg0cKhm9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(6029001)(7916004)(39860400002)(366004)(136003)(376002)(346002)(396003)(478600001)(26005)(52116002)(6486002)(33716001)(6506007)(316002)(6916009)(86362001)(6512007)(66556008)(54906003)(6666004)(33656002)(66946007)(2906002)(4326008)(41300700001)(66476007)(8676002)(38100700002)(186003)(38350700002)(1076003)(4744005)(44832011)(5660300002)(8936002)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bXN6sx9wYJNXIKAbjySnIFxkT5Pdvi6+AVz/dqhrXYAWLIQ32P7IQQ1I4gqn?=
 =?us-ascii?Q?QFn5CzjvJ1mRTyTmcKFBUFqpKDocs4oGnZjnmC5981jNj/m/P4877WOvvC4W?=
 =?us-ascii?Q?3QgiYFJRaRlxmkqQlsZKPQ8qp/LJaxOzJRymyT1prqDTaihy5kKIxJDjN0kC?=
 =?us-ascii?Q?h9wV9ROFD7uWZBKVWyp1FhN0bvip/IV6glLaxnf6Pi4Su5orYgKo4eoYjynb?=
 =?us-ascii?Q?OR+xok1iqU40bOccBDDHFKC2aljFgq/f+QVGll/pivlmNQBzKFiV5mXoW+JV?=
 =?us-ascii?Q?YXu94CT6fLSDx/nCDAbtBvKCaFI1QRuyfomo8f9h+3inHqBPS+8mx6XqMiAK?=
 =?us-ascii?Q?4HHUywZ3JZ8xbDJFGtK28vA1TanUWtysprMzNUrolmFqv7P7exIScQX/fUQp?=
 =?us-ascii?Q?qwSq+yjz68Bcd348WkmRv1pC/sJkWzEL9K3ESZQ979SzUVgCDtekDm/WH/Kb?=
 =?us-ascii?Q?s4SrEG7nLDgunJMpIwxKCiHXILKxoQb2g4eDt5XW2t80xWGlKBjfWFKwDHGb?=
 =?us-ascii?Q?y0Uzbg4AfjkqmqA3K3/wbvwRiHVMtEBVqI7L9il90m4vUeqo51A84GGBGZK8?=
 =?us-ascii?Q?nupM35mixEcNYzvwOzEEf/fobjupeyzq5AeaEYJd2GBjKOm34KI0rUVrQkXE?=
 =?us-ascii?Q?GvfAz4dojqIHzcKp/uYxWxLp7yTofBxGtCfoZQkuKEE6Z5ue2ut1j93vIUxu?=
 =?us-ascii?Q?mchxmssWYtPC12YJIMFy3vjIpeldtBqUVj01Miy1ykonQfTYYp15NPt+djjj?=
 =?us-ascii?Q?sMtM3OM/OCIdO6n9iY2nxmcFlDGGswYw9bBvOSK1AVnQGIL1Vv40kqyup0On?=
 =?us-ascii?Q?giDezaMzQx3Z+CtEOCQ5+CQFuTghjVKprheGZX76s4TSQZt1KwpzWGeaxyNC?=
 =?us-ascii?Q?gGXRkX/ugIRjW8KzX9V8HhlwPMGEEXCzjlmhLa0CLT7A1MK9hsjJqyf9lrb5?=
 =?us-ascii?Q?AysVBqJGQnk84jdYM+koA8wVi+JqzQbqr2Vu7HsQNnSWMAT/EXr9uY+DheNx?=
 =?us-ascii?Q?Kxj6mZtYP7BzyUzCWOBosjwymiHvc/Wyz4eJEZPxEqcAB927fPIpRwJiM+3M?=
 =?us-ascii?Q?4fLSdJKwt8YS0DY1tZR8Bs+3kO2iddzzvaQXreCIRK2HQNavgjeWOkNRt08h?=
 =?us-ascii?Q?PV5vZqb3LXGaF4nfkaWYkb7A+5iucPTPrjmze5M0dUmXIfgnC0t7THTj8jmF?=
 =?us-ascii?Q?2/CaD65R7vQvqfmjDWQFWHjjj313y6ohmbErjENJzw1XLz0QvhA4UEnPtKbQ?=
 =?us-ascii?Q?lpKVAsLlamASEQlL/mG4Ct7vmEtDnI1pr4N5UVZWm36bCRdl3hVgStf/7Tuf?=
 =?us-ascii?Q?y0LnBk/avz3TsqajBvDzJu1whtYaSuKhDutrcPxXhCCb0YNRMb8r0FZ43tGl?=
 =?us-ascii?Q?Vj80UOVMbHYQnI2KdqlRWKdZIgiIRX5NKox8Ve6MT2JIr9gEHEm2H0jzZ5KW?=
 =?us-ascii?Q?FSAei7wj6+z/qm6RzxChVsCq8Y+y4SOThpB7gmFpG+yn2IluK6yEdbJvJsIN?=
 =?us-ascii?Q?SHTfV8iDVzZW3uREhpxyvkMjrxaDLUAefccu7nHncz+Um9iUIc9hp0GEAvi/?=
 =?us-ascii?Q?LWNcWz4Ez1sBGOt4tOQf1qp+E5z8uSIqfMc1SwjbP5UYZrIjB2orgohEtSTC?=
 =?us-ascii?Q?xA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eed5413d-2fa2-4726-36c4-08da68bae012
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2022 12:41:47.2903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dpm7e12YlpYWSaAmExXnx37iegeV9Q+B5vE6ObpIX1ZhWDriwKRQywTPHcjVWRpOi+Gozq6Kgs533YiMC1XadY6CVojks4PVFWm6HfrW47A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5201
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_12,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=757 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207180054
X-Proofpoint-GUID: Thfig4HmsifiPF5Xua50SahK6N2Mrp98
X-Proofpoint-ORIG-GUID: Thfig4HmsifiPF5Xua50SahK6N2Mrp98
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 12:20:25AM +0200, Philipp Hortmann wrote:
> checkpatch.pl does not accept multiline macros.
>

What?  Really?

I tested this to see if was true and it just complained about potential
side effects on iobase.

regads,
dan carpenter

> diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
> index 5747de436911..129a6602f6f0 100644
> --- a/drivers/staging/vt6655/mac.h
> +++ b/drivers/staging/vt6655/mac.h
> @@ -537,16 +537,6 @@
>  
>  /*---------------------  Export Macros ------------------------------*/
>  
> -#define MACvReceive1(iobase)						\
> -do {									\
> -	unsigned long reg_value;					\
> -	reg_value = ioread32(iobase + MAC_REG_RXDMACTL1);		\
> -	if (reg_value & DMACTL_RUN)					\
> -		iowrite32(DMACTL_WAKE, iobase + MAC_REG_RXDMACTL1);	\
> -	else								\
> -		iowrite32(DMACTL_RUN, iobase + MAC_REG_RXDMACTL1);	\
> -} while (0)
> -
>  #define MACvTransmit0(iobase)						\
>  do {									\
>  	unsigned long reg_value;					\

