Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF44E5734F8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 13:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235276AbiGMLKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 07:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiGMLKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 07:10:14 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D52473932
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 04:10:14 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26DA5jcW023048;
        Wed, 13 Jul 2022 11:09:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=qJhay0kEwXBy/rDQ3o6/upCoHrhhEiz2Uf4NhLo+0YE=;
 b=rk/6VNQIxHaahIULquC1pBOsxbd3xGwTXC+6RtoHEwVrqsE4xCrO3CtIUTbIZReneHhL
 YYw1q+12x/s1VK6FIkztAzfSZCih5NYjqEtNvml5Ve7d9bYyo0oGRZe+mvkwXl7RESDw
 uJBFD+lHLKTZAW7l5DS830jOKwOtaTJjq45dbX8Bf9sM2ORAuOaG3heppBiTe+WnQyXl
 03K5G8f5gEM4gZGz2LHrro2Q1Jb7BJW98Ptm9Cdz7+Zxmm8pf6akBMjOoLwFgOLA/0pQ
 a5bdYWdFXDfh7l31OWulb8w+VLln4/q/GmAA/kn5HzWZORK8VL+wEnPRL/5cl0kJRY1p 5A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h727sj7ev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jul 2022 11:09:42 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26DB5bSr023345;
        Wed, 13 Jul 2022 11:09:41 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h7044k0gm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jul 2022 11:09:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RAOSEv2BPSbf+kb3vpHPzEbUhEOwEwxv7Pr1gln/szv90SWK+zoX5eqYrM6HdMN5N4esl85Dmqn9gmIH2KyMkwAwzMQWqC+aSZ01CbuFxnhZNWF5fYVH3VZKnTS4GLD/BYrXRShcJNH5gF/ty8VN3k1ThyP4YAiFeRtJKVoCm+79SGkhsOdBtwLfzsCuhiITmMef9LxgXaO1h8EF1EMVL0nK8Dw+azvws3oWi4rhyEPvWFKjdVwYr1s2fic+ZNhCV+pTMHn99GJAtUVhHGa/WHgHzruEFVn+4zZVi5kCcAmkiILIDToW8H2A8BFmQkdH3PnuFNUK5lRwzxHSb7uefA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qJhay0kEwXBy/rDQ3o6/upCoHrhhEiz2Uf4NhLo+0YE=;
 b=O4C/kF39R/ARauFomGfPIcHvYDT+2GIl1G2qsDPQdLuM699+BQVDj5kMQY7bh5sBoQFr/dXWDVF19OG18Mhm39Mj3HePJrThJF2ZbczJixgnegk3kB7h+6VWNoze9ey6Ek40fYlDJXf/nriRVWm5ND6DkP/PnUI+jsLrNUgXvpB4Kn06EYc1laPdF6hQuP21ZnNsqrj+jiaNBNK8T30oIoSOUKwG4pV/VEUBjgPAujL8Ti7fAwtdYMJROKGBKSYmXP9vthwZ6UX0faAo1MmqOCYosrqRjuNp/v0Cm0fnyT3KVnKAFxjEEAkmzETodAGpMi0nEdqPq9IQ8rfwTSL18Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJhay0kEwXBy/rDQ3o6/upCoHrhhEiz2Uf4NhLo+0YE=;
 b=il2XDTznIfmqkPZOuEMdRsZjiYWeA7P1R1+Jfw/5/29k8d9hQd5sTQ2WkqOSFMEV3vUy6A71iV9Iyys/D3PeiY/685hGkGdcMmeILYvveKhKLzsxM3ThLwqzCIQQq4iwmlCmvejt/u6E8sdTZUyH1RDdm3N3EZ/XrY6aYIy9IdU=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by IA1PR10MB6076.namprd10.prod.outlook.com
 (2603:10b6:208:3ac::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.20; Wed, 13 Jul
 2022 11:09:39 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 11:09:39 +0000
Date:   Wed, 13 Jul 2022 14:09:08 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Joel Slebodnick <jslebodn@redhat.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, nsaenz@kernel.org,
        athierry@redhat.com, gustavoars@kernel.org, keescook@chromium.org,
        stefan.wahren@i2se.com, gascoar@gmail.com, ojaswin98@gmail.com,
        len.baker@gmx.com, jakobkoschel@gmail.com,
        linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, jsavitz@redhat.com
Subject: Re: [PATCH] remove custom return values in vc04_services
Message-ID: <20220713110908.GR2338@kadam>
References: <20220712181928.17547-1-jslebodn@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712181928.17547-1-jslebodn@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0064.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::20)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0584b2e0-d5aa-49b9-d977-08da64c02da9
X-MS-TrafficTypeDiagnostic: IA1PR10MB6076:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TUw0SgwiHQIfGqYyVziJQ63N5QZNdp83fYuA/MCRexznwFNidfX8a9TLNBaOq3yKXLVvQ5W1rois/zHd439v57iecetY8L6ojUrpFFzvG/FMEhRW4TIYjjClSLdlGMtykg3+xXFzBa46myWziw1QwzK34qr8JVFuyJC91vi9j+VQdz9ubbpGSvb0hkh3BNtC4NqVdgLkcegFmlEmwuhsPVI/t0fTD4/7ZXjiSCmvZvHC86d+gwhFTE7idx2M2iMU6galJGQJ6g2BCEhpzFEwD6MvauEXHSc+1WYtQAkiI5KNxIhu/SODdBfW/0BRPEUshQDD1gPfW8lkTbZ+xmUpFm7sf1SrgiJgkfZ0WmShyWI6j2BrS9H2itHHGouPXWN5lbPcTmYcaR3K/Xw+hDjBxxdqXIEby/nQdnbzKm8HDvFlmU2ZPTktX5L9m2ZhvGv0WvShVPE8mEP9ImkV36nHny+rg+y6ERhC6HQF/X1GVK/GmuW6I0Vf7piuNpjmC1/DwZZ/HH1MBiE5otyO+SoUj5H44uWPzDEJPmW+MsLyuwsF+GKmtEOsrwm/TBUgL475SmmZOz7LJpt3EhJKdWM04zDOOqM/1T02D/3ugJFpSGfsl2QQ3xnb4ETilYyj9ohVOVwwGtxE1cBEGLgZTYKSgSW7R/Ihiu3PwHTDrZKtmy2mJEQEAw7HNKvZB03pOICC6hrNmfyNmEaLDhOURc66fmXMw2Hb8aMW5yKL3wBwdpMZICa6mAko/NW1VUFEbKFIAxzqzuBQqR34chjZrxPU9PmNqxc/+z1O8pSLe5Vvy3DgKVSqysNyu1pySVQXHqyU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(39860400002)(136003)(366004)(396003)(376002)(6512007)(38100700002)(52116002)(86362001)(8936002)(478600001)(26005)(9686003)(2906002)(33656002)(7416002)(6666004)(1076003)(41300700001)(4326008)(6486002)(316002)(83380400001)(44832011)(8676002)(186003)(4744005)(66476007)(33716001)(66946007)(6916009)(38350700002)(5660300002)(6506007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5/RLoZhtHICOAJ7dq16TJv0XEnqlMsLHQEDP5/vNpftbKB/Buludt7Myxrh8?=
 =?us-ascii?Q?ZLZRS8aLwHU2cl+c2NdhC4X0ek1RR9w9hPQlqiTPrdNOso2iRvwP3XlFoPPT?=
 =?us-ascii?Q?2DJuMgza7MeE7NXvLq/uY6FUpHjAe683lRtM4CLZJJz7bK+8lLmflopcLUbR?=
 =?us-ascii?Q?OjgBlSrPO0vMwS+8UNh30qpWQrXIOLNblNQ+oAjS8k/HQRC3pyTuFmvnmZJX?=
 =?us-ascii?Q?XnnFkOVceMracsNEY/34e1YlgjmmsJaJT9z3JwukgSStKx2yLd2p45/3dFnn?=
 =?us-ascii?Q?iZhpOl4huNOaiSWzhsWEKwbHp5N7wgthpMvQ/Uu1Vhygc2SplPQN3Vlc7UGo?=
 =?us-ascii?Q?UxFv9YgC9sX8XcJcwbMS8YMy0K0E1nyF6CVQpwIwwIMUgSNdWNgidoMNms1k?=
 =?us-ascii?Q?OENmvZtCOxPSNbyzTtmPxsLBnd2v4qI1s2+f2X7I0M0E/yZMooDAWT9+xOL2?=
 =?us-ascii?Q?r6f+tckc6tRbVxEt/HywyEsr0m0gbf53xqPGA3WIUxn/2otmopqIJQrr41RM?=
 =?us-ascii?Q?8OXg/Z2AVX8ltg02+y1TUa34mHzGjZwAkS6q283jBsOdkKMkfnomw51qBEMO?=
 =?us-ascii?Q?iZYDgT4tN+VJ2cRRTp+3WrECIMfelH6cMav7m6wz9yxfg5kgLbxn2n6N0mx8?=
 =?us-ascii?Q?UhKc8ENlwel+Pdjf2x2mvfldR9lLE0L/xaMamcFWvEfUW3D2uIOcNnbkTaHB?=
 =?us-ascii?Q?nKsC91YcqT3Ri4NkdWPqaF6lHY9WgUxmvd7ZJyPKCgHKkhrjBzJhGxwurNid?=
 =?us-ascii?Q?Fj5I/8Fy2NHEq5Y8T3y2j8YqaMfyDqiC4LfqnwylC9xxOSgb/cjn6ByVpTYl?=
 =?us-ascii?Q?QdD6cymOmbZ1XSrPLS8ajtLEYsb9Y7wtpnAjxg6mvBn9FWTlVGld8zcJku6J?=
 =?us-ascii?Q?nM0UqLZMh+sdrdys8Hf9+vvLBpmnPI4TwLCKpVj07f1QF7W1t7l5xJYZZ0JI?=
 =?us-ascii?Q?5kugEXZmORTabkmVfhBglj6S/FgINJFSac7P3wLo+SIq+XPBc0YlF5FF3PQF?=
 =?us-ascii?Q?J1WBHeAM3Cce7o99KIp4yR1d3XxSYBrxezeDI6zWE1JszEtQWBeTH2SN3drs?=
 =?us-ascii?Q?j2YoG1N8Qt9BdjnW8RpPbpHw1e4glFaFnSvaVAKUNAf/QclSKSLZGafZOBo/?=
 =?us-ascii?Q?LodZGmGlt5uSUuMmXcPeDAFUHo6nV93K+Arxed9XMSS5txFK18NtqQeMRu+C?=
 =?us-ascii?Q?CZw/JR7Syx/MSqk25P1xK1bxzsyRvYdU7+IULJ1QWsH30RrdTKejcav2nk9N?=
 =?us-ascii?Q?ZrNBCoYR+Cjd8C62mHaGLWjebXhYhyXl64JaLSS60HpSQbS1peNbJKGVpWyR?=
 =?us-ascii?Q?8N1I4cBJsABZMH4pxsiIoGRuM84vQ9PWlwqdkAncw+G6ifqgYsy0lG2aOtd5?=
 =?us-ascii?Q?y/1HfgA2VpY0WEUiIQ4NUEnrcnj0QFciMnLcTaTzrU5Bvja8sjR6CvZ90VNX?=
 =?us-ascii?Q?XqmZLENobMBsNDHzAWM6fazDM+z4B5Iw7e+76WZFHTEISJCaTS8GSOr2wvNd?=
 =?us-ascii?Q?iSBg8ZFF10Q0J9BOGbeZwB4fPrNWY3wnxMy/CsKrR2p5oUDSnfSVBaqmSyb+?=
 =?us-ascii?Q?S0Pa8eUgPqIh58qAKyTmzq877ymtq/moUcAzUqVkkFMhDl9sjxPy/tZKOtma?=
 =?us-ascii?Q?hQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0584b2e0-d5aa-49b9-d977-08da64c02da9
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 11:09:39.2544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i0DofWAHfVHXvc2xm2yz7IFaSqsRT/PMkAQlTcyUjI6cB0W2JyJE9UsfOE+HbKlt5JwqTGn6QRxkseH+5WlTXRbYt8xazSxuE5+im77miMY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6076
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-13_02:2022-07-13,2022-07-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207130046
X-Proofpoint-ORIG-GUID: NeNlqZZhLBeCOuUL9nK5Nwe_r3b9vicW
X-Proofpoint-GUID: NeNlqZZhLBeCOuUL9nK5Nwe_r3b9vicW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 02:19:28PM -0400, Joel Slebodnick wrote:
> @@ -3264,27 +3260,25 @@ release_message_sync(struct vchiq_state *state, struct vchiq_header *header)
>  	remote_event_signal(&state->remote->sync_release);
>  }
>  
> -enum vchiq_status
> +int
>  vchiq_get_peer_version(unsigned int handle, short *peer_version)
>  {
> -	enum vchiq_status status = VCHIQ_ERROR;
> +	int status = -EINVAL;
>  	struct vchiq_service *service = find_service_by_handle(handle);
>  
>  	if (!service)
>  		goto exit;
>  
> -	if (vchiq_check_service(service) != VCHIQ_SUCCESS)
> +	if (vchiq_check_service(service))
>  		goto exit;
>  
>  	if (!peer_version)
>  		goto exit;
>  
>  	*peer_version = service->peer_version;
> -	status = VCHIQ_SUCCESS;
> +	status = 0;
>  
>  exit:
> -	if (service)
> -		vchiq_service_put(service);

Too aggressive with the delete key.

>  	return status;
>  }

regards,
dan carpenter



