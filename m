Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A3A588BD1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 14:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237779AbiHCML5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 08:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235651AbiHCMLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 08:11:55 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E797224952
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 05:11:53 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 273C0U6l010248;
        Wed, 3 Aug 2022 12:11:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=i3vrGtLKk54GjywNuOjyLBp9+Zl8eSi2kBgveh0LTXg=;
 b=hsVlwcWKJ303CcKotqoutIVholfWadcE3VXILpPmWy+s9Acro2eXxpfyJZNcoDXxP4xB
 OVAPGF8OgIcwTD56okXuOa9uCNazc/9PzKX7NSetyNGQjqdBwgvUahlnD4mWvgTAZzMr
 71iMl++UGycDJ2b2fHzZ7Pc+InogK6OPFg3njFufOtd+VLZZmYeNEyuBuB2sqbpFaAi8
 bQ96TC34O2jltaegUL11QBm6aRcvOm9WRwbkQcA5fjuBnnv6xnSgOw0FRIpk6RJemQ+M
 wm8lxs9VYR1uQT/rK+AOfjcoOFbuDeCRglNIv91OKcoKBS/TrOb8ABbcqdn/t066F9Eh 8Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmv8s9qyj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Aug 2022 12:11:45 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 273A3H5W002984;
        Wed, 3 Aug 2022 12:11:45 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu338yty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Aug 2022 12:11:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TprxqMbHicL80Q0cVF9YZGMMZQSc2Ewli3vB0DMnGVEeSeXN+Fi5lRphb6d8LkagINlcsNPTqXpe2/lt+MOmmyeyVU3m+KaykoDJ+a3o5hRmF/J3z+fBfHFFXQUm2JtHcmlxkxMQD77a8zG1jS7ceDdZu4KkFd5hEbOk+AKxAtHT541eoqGUnTzhfGWqINjl3LpXcoEtUjfqp5w6AF6hhPMGZYpQaGJHOG8ZuLFfKsLROvT6+wbtiZ/60uJTODVRXi38NAvPtteWaLjM+W/7/ptdcFgo3OEnbAtPltuFFSxAVBU6Y0iDiRvC5H645FbCyaxR+1GQcVdDpWJswYpFyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i3vrGtLKk54GjywNuOjyLBp9+Zl8eSi2kBgveh0LTXg=;
 b=HAV2ttW7PDE2P0zVBHlXmWwkVFmZLetT37ECdadk81JY5FQa4EPZ7lkFil8ZPHLAIYavLcyGe5oyuRNhFuyurknnC/6aGu2RwQF2OH0kTqxI+ZtNYPPfG5tO0ihIbbjhhNZdZEaoQdPLx4lxAltO0TQrsjW6M10zeMefwIk8ysHvX8y91D3Oly9Qod+AVmrSY0wESUsBAQs16BgUCCABvlH4a3ZYsy+bQM35VcpWAXopElnoKN/mWdj0KY7y2aES7un+QINRhVFGBxZmZjpYOZH769D42wRBNNOOmm1liopcR3AtmqBlhakrKyUH0uIw81ofmpnpq1NB25fPXolUqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i3vrGtLKk54GjywNuOjyLBp9+Zl8eSi2kBgveh0LTXg=;
 b=lvsN9uJb985TCWJP82ONMKFVJWr2kQTmBicxr9UbZXh9h8fqDZPk+/3jg9VFdb5cB8K0x5HiunDTxkVFk1DTzhlFAWf4d+YLgDZDjIUYvC8bSdYiTNwChJHzZXda+HmOyz8qh91jqn4P4tKmwoZq61cpTx+31GV2AXY4O9V8EUQ=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CH0PR10MB5050.namprd10.prod.outlook.com
 (2603:10b6:610:c3::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.12; Wed, 3 Aug
 2022 12:11:43 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5504.014; Wed, 3 Aug 2022
 12:11:43 +0000
Date:   Wed, 3 Aug 2022 15:11:08 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        paskripkin@gmail.com, straube.linux@gmail.com, martin@kaiser.cx,
        abdun.nihaal@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: convert rtw_p2p_enable to correct
 error code semantics
Message-ID: <20220803121108.GC3438@kadam>
References: <20220802234408.930-1-phil@philpotter.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802234408.930-1-phil@philpotter.co.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0057.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::9)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7bdcfdf9-ed20-4e14-0179-08da75495389
X-MS-TrafficTypeDiagnostic: CH0PR10MB5050:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EUS8aadowDwtL/M9xQH5N33PLSa9DWDRgGRGfP4Y1/HJvulZ88dJWmFlsMRnoDUbuOTrl94Egut6QbXjL1Su+UB+fk3a4Tn5921HsC/bT0VZ1hFh/1bo0peFFlL+727jyNqfOIri3IsGn78wdKTuyPE3jBh/AB2TYJENkTpV7RMUIRvJCJyOdLKLmzRuGJ+OjUlZ6XH9sZ10amh1VdG5ZILjCH3VQnqUWk+T4sbR6sibrFoXaDQadkcFLgB1WMG7QLxmCcJicoRNHfWptRCj+oNjrnjMUMKY8g62XzvIH+6mC/Nyjp2F30Kexvwgu6dPcz1pS/g9l/iS/8LSuzBs7UFtUJ3FuRFaFronItWvEDudN7ZI1B2ngehHL/RAFD1EjyoJl+HRpzXmeFnV5xHCbk/RwwmIepmuHNWUPg/uoc49J1ABr5CzFMaieiPHP23oGte6Bh7GjKLCugtVIiJjUQUOe/GyqDu/lNK4O8e4zJTbsBDeR9RVAB/VpoQ6EnnQK4bnclCEpUgD2sn7Ptt4wQS3JaYyeO0QZIzTa7w3PG1osW4crRLyBvOmBOcxREP+Fz3Jw3pRIIWZBYMFGmRrQiXffXSvaRXqAaVZihTerzMq8/SKXQ0fXhEhhvfISt+ytYPWBY7nPEdCl9TBQKP3RJDOznXTTMz+5NaY+ACZeHu8puHtMYiHHRff7tiFgkdmLwdcGVOfv5NEmY7ADmYAEHaw0KDxsFcAqOCDu2BHxjyqpX463UdDXyQKsURhiGGzTNsApA0YNQ6b1x/HqvIiZwQ3vCSG+JPJ6z/1nSrkRtVd9n+BOj/ZYMcQEoyZ6mW1dQE580rDNnLI+Y0mcoyZ1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(346002)(39860400002)(366004)(136003)(376002)(26005)(6666004)(6512007)(86362001)(41300700001)(9686003)(52116002)(6916009)(6506007)(478600001)(33716001)(6486002)(38350700002)(38100700002)(1076003)(186003)(316002)(4744005)(5660300002)(83380400001)(4326008)(33656002)(66556008)(66946007)(44832011)(8676002)(66476007)(2906002)(8936002)(70780200001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Cai/mI3Gjsx9CQwuUIbKsKBjzB7Oj8SJ8a49ijxO2HsbRgspZdBxXUpK/xK0?=
 =?us-ascii?Q?PbvkCptpo/M049Qth9J9DtrSYTTsBqqhuzbX4UC0+6BYuWfTJL4nXK34T3rO?=
 =?us-ascii?Q?LCRlXyKAG//zhLJknbT/wwf88nq2tXXheePO2SPux2wKBt0HoemJMq461dmG?=
 =?us-ascii?Q?mByUIbSiv7eRy0aDM2eFwwcGGFplbN54pmjOdL+0kTLAXF831k2AlzaDmC7E?=
 =?us-ascii?Q?uuB/hVQ2kQOEZAJRtEO7sxmZVuE7OcR0aeG1+BJ57BWsKGR7cX+UZjfY2q+c?=
 =?us-ascii?Q?CVvLIEAZL5JlNOF45W1e9SQMJSsIzHeat32V4BxaDJPaL2+3hfss5A4hjPAD?=
 =?us-ascii?Q?iy7jeWvMSIhwVT/jyCthnccETDBVLuaa3vY1/HLE5NXUkXRbGcXhe5jRq/9x?=
 =?us-ascii?Q?Kwff50G+E6yvBc1Gc/Ok6Ho2gi42zJTVeENK3Uo1fn74TNQ7Fe/yanNdpEtU?=
 =?us-ascii?Q?XQUXymulHfDsGxS45zVHAq6FUDhECL7+4YsfnH70FWqY+r86Y8DwL+QYspJz?=
 =?us-ascii?Q?IXQu1Hbts5+w/fkzN+c+KeBsQLX8XkF+Xe/SfnUc59sGlyo1FL4gy2NdAbbm?=
 =?us-ascii?Q?DHONrjvUf3Zaiqvk2JUAVbycEhtl41ZKMmy8LSakr6G1nEgohoVApmSM57Rl?=
 =?us-ascii?Q?gTryIdLnPM/szbM7TEGX5xQihTT4X7fIS/0qPPXoZdYk+t6DSNzLocmHvSYm?=
 =?us-ascii?Q?JEvQb3qRjuFXj+PVKOJ9o2vHgdUZ3uDi9t8ZDyXEqMuDX1YDOoSz19jkOp4W?=
 =?us-ascii?Q?cWnMPW9Za645D4fS4jviuJtD6PDzATaoSeyNczM3fIzcM1ezF2wLWwTcO/9p?=
 =?us-ascii?Q?rQgfXLnjrljBjQdgh5XD67H8dm0M5Fxm00jz9ft6J1CUSvRFfV8Z19M5+PYU?=
 =?us-ascii?Q?bFNkYoyWGVKChMCCehTBk1UEsq6vAfp102JlxtVGY6xezer+Chif4RviWzBC?=
 =?us-ascii?Q?fhQHJxwbzVLR9F824sCeDei/bHjRu34JpZ2Dpn3WSTqX6g3rhzsLrSKo1xq8?=
 =?us-ascii?Q?+v/4QPTKX0KZd47ZhDXjrIEt+7nw8tosigZ6X/4Zh0w4nlYQR6Z/aKZ9vkmG?=
 =?us-ascii?Q?nVLTvs9K51bjBRoATX/ZjNRxrqdbJcFQvWWsktnwh1bX2e+sdrWf9x8QJDod?=
 =?us-ascii?Q?/PbytkZaQ7zpeh315W990fhPzdoj/qpg9uHpOEuKeYQOYj+hVp1f1GP4o6b6?=
 =?us-ascii?Q?1wBCkMiKIun3KSs5a3MeBGJZORMYdotLVv9De2tzGUeuSi2WiI/UXSRtuNkH?=
 =?us-ascii?Q?WTFFwlthCH5A5QCSLu+wcN7RY//GK7v7zSBLJJ6eZ6sJ/hpwDdD6PCDjbcLS?=
 =?us-ascii?Q?OjMMoh84tBKk2xrEpcFpLEYIMm1n4Mm4N8AskEZpucex1/k900HSVjVV0MUT?=
 =?us-ascii?Q?U0sptwe+Y1hqLI12CPFndGl458XrBKtJpDOCcp/d28hLTZlfjOl7rjr5iVGW?=
 =?us-ascii?Q?ib2BTGf+c4ASp1j9VRA+R9y0c0DDc4l/PlHg7gk417za1xK3atdGu51Zt5Ew?=
 =?us-ascii?Q?BIQAMwbYp7DTJ84mZCUKr6OAWFHScNEvfYgvlJAaNWzcDTMYKGORvZmLPhoN?=
 =?us-ascii?Q?9rvkwVH/JvvWszBoWxDWe9TUoSIRU+hvYGMsMqhm?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bdcfdf9-ed20-4e14-0179-08da75495389
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 12:11:43.0114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UtFmJA9CZ8tbtUr6+5RzLKAqGBC6R6iJDT31NEluDg1qfmmwTB1K9mQ2+7TmN/6qVwggKy9hFDCoEgEG3iZ9tMmHuXfr7sSPsTur4Wsb4jM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5050
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-03_03,2022-08-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208030052
X-Proofpoint-GUID: aSnXof17eGTOztINtYUL6_TDDKnS1XWd
X-Proofpoint-ORIG-GUID: aSnXof17eGTOztINtYUL6_TDDKnS1XWd
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 12:44:08AM +0100, Phillip Potter wrote:
> Convert the rtw_p2p_enable function to use correct error code semantics
> rather than _SUCCESS/_FAIL, and also make sure we allow these to be
> passed through properly in the one caller where we actually check the
> code, rtw_wext_p2p_enable.
> 
> This change moves these functions to a clearer 'return 0;' style at the
> end of the function, and in the case of errors now returns ret instead
> of jumping to the end of the function, so that these can still be passed
> through but without using a goto to jump to a single return statement at
> the end which is less clear.
> 
> This change moves the driver slowly closer to using standard error code
> semantics everywhere.
> 
> Signed-off-by: Phillip Potter <phil@philpotter.co.uk>

Looks good.  Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

