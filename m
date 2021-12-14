Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78B82474106
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 12:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbhLNLCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 06:02:23 -0500
Received: from mail-am6eur05on2067.outbound.protection.outlook.com ([40.107.22.67]:16264
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231608AbhLNLCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 06:02:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7ZdxVOzAtXB3RXN8VdcJQkLCGmfIjYFVxZfLrKDAHE=;
 b=PtP41OSA7CYIs8m4MBa9caF6Qjvy3NtdaoIaRHihoNuoQcLOEjrLiT/87M40UHsBYiftggIZADBIX6Is2KrIOgtEtOSoiCPl+JGkDRKVNJgjR+zPQiKavtBLTeF0Y69QMvwBHVYNkr4j7uZpLrbgXLO4nl9thqzSFMwoXn6LQeI=
Received: from DU2PR04CA0355.eurprd04.prod.outlook.com (2603:10a6:10:2b4::34)
 by DB6PR0801MB1974.eurprd08.prod.outlook.com (2603:10a6:4:72::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Tue, 14 Dec
 2021 11:02:17 +0000
Received: from DB5EUR03FT009.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:2b4:cafe::9c) by DU2PR04CA0355.outlook.office365.com
 (2603:10a6:10:2b4::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.14 via Frontend
 Transport; Tue, 14 Dec 2021 11:02:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT009.mail.protection.outlook.com (10.152.20.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.12 via Frontend Transport; Tue, 14 Dec 2021 11:02:17 +0000
Received: ("Tessian outbound dbb52aec1fa6:v110"); Tue, 14 Dec 2021 11:02:17 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 1dafc4b2d97f7113
X-CR-MTA-TID: 64aa7808
Received: from 37de42b292e3.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id BF6E6CF5-2A67-44A2-B58A-9B97DC6CF473.1;
        Tue, 14 Dec 2021 11:02:07 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 37de42b292e3.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 14 Dec 2021 11:02:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I3cjYnYRxtmudSm2RREi1AwUqzBNPRvuDHqE2HmV5e2pxfcV6gtQkazfvSFkzlp7yq2J9owg1D8f0PoleDwAuVl+1XoYP5P8Ms6wvoahAiQb06Hs+ZFB2RPB7l/ysPWcJ0h4JF1M4S74oIOhMkssjF5bSZDg6hnJCpU7AGmZkcBgRNOVrnKRR0L2EcqC1X9hiLwyEAzk4w16gBLF4HJR9n2E82sQpJHdp0qEkV+KmkmMzT9EyIJ2slvuUhW+g1W63s6wLyOxleLVLHiHIyLhG73sNqrYH1nZrhYNp3g7WdJ5huG1rxUeclIyNRsYaZSJbT+TVVPWmPPdtVsOFORTnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C7ZdxVOzAtXB3RXN8VdcJQkLCGmfIjYFVxZfLrKDAHE=;
 b=PRyUxEB+1r1he90vSGeGuwqhBY7KDp3VNz3zb/8XZGGYpUakw0ArW4YEQI6It7k8iUbM2PbKhwcFnmKFpkGjtm6W73tD01OAm+9hbU/X0AF4Owgle8eIhNzunXQtJE7Ii2cnED/3+qI0dSSDNYBCP8jJ9dhBs8CC3E3noR6shnk/Z0K/uTMfpkIUcSRtE+afYuVLO/ndKVGSWp3LXSjEeDwF/rMAanBAyaSYY90U4VjKOISsBN18jONaGIkosikBtXOcZOINpJXeFckfZvky1lPsKVxXt+Zwi5S6VG0cuKpHfGYoGpmCfAJOri76mk8AZFUhhaMTdl6QDG7Hi/k12Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7ZdxVOzAtXB3RXN8VdcJQkLCGmfIjYFVxZfLrKDAHE=;
 b=PtP41OSA7CYIs8m4MBa9caF6Qjvy3NtdaoIaRHihoNuoQcLOEjrLiT/87M40UHsBYiftggIZADBIX6Is2KrIOgtEtOSoiCPl+JGkDRKVNJgjR+zPQiKavtBLTeF0Y69QMvwBHVYNkr4j7uZpLrbgXLO4nl9thqzSFMwoXn6LQeI=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB6812.eurprd08.prod.outlook.com (2603:10a6:10:2a2::15)
 by DB6PR0801MB2085.eurprd08.prod.outlook.com (2603:10a6:4:79::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.18; Tue, 14 Dec
 2021 11:02:04 +0000
Received: from DB9PR08MB6812.eurprd08.prod.outlook.com
 ([fe80::fd1d:c45:53d5:79eb]) by DB9PR08MB6812.eurprd08.prod.outlook.com
 ([fe80::fd1d:c45:53d5:79eb%9]) with mapi id 15.20.4778.013; Tue, 14 Dec 2021
 11:02:04 +0000
Date:   Tue, 14 Dec 2021 11:02:02 +0000
From:   Brian Starkey <brian.starkey@arm.com>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     liviu.dudau@arm.com, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        nd@arm.com
Subject: Re: [PATCH] drm: mali-dp: potential dereference of null pointer
Message-ID: <20211214110202.unexcdiya3qhsvzc@000377403353>
References: <20211214100837.46912-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214100837.46912-1-jiasheng@iscas.ac.cn>
X-ClientProxiedBy: LO4P123CA0301.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::18) To DB9PR08MB6812.eurprd08.prod.outlook.com
 (2603:10a6:10:2a2::15)
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: f8a04912-e2ff-43d6-8079-08d9bef13131
X-MS-TrafficTypeDiagnostic: DB6PR0801MB2085:EE_|DB5EUR03FT009:EE_|DB6PR0801MB1974:EE_
X-Microsoft-Antispam-PRVS: <DB6PR0801MB197428E0F978257414D7DAF8F0759@DB6PR0801MB1974.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 8xtW69M9a8Hn6bm1fp6VwPiXobAIw70rsjTe0tNZpgJJpDAg/Zh42gTS8VpoJ3/f0W0SMt2MCjD0wvJNA0PAGxu3kDzSjrr7SAgJ32HbrdG39UJL7PdbIXiV3Hq32cuSHiTjZ5fEoMFhGQyNIPaX6Rkj3WFw+69XN0kmphtZ7lJxeZ6pMD+kTWTAe4b3mINDUAJB5E2lNdX0Xf1DsHKUHKvNV21Q3DSvnqAUsooIpCDi5e970trRfkMfYHtfTLNHL5JSa6zjy+l1B0ZZVnSeszdQ5/FY+zsb4t49CAX/7A2eqPM4Wy+zmFZklHGv/eWrLhpAs/Ad1B6YBFopZ7FiphKB3kB8hesUr0NJan66pTuNqXqw3XYuyPn7aVNYnU/KaHaufJ+ZBdhqKuE9Ju4BI3BRLO0sjmQjLzzk2wvGa1rJyXYPGHBoNRoSTYAjD2lPgSD76GK+UqsgC91omfK2YHtx//TBZzMCj3Ht4JtW5o/eQhh9ynOTzmX3DNJN9ggM/F+3boFEulj6w7T+JklNfOKmb4OzGLaaDyR1WuIBiuOCCoeLrSRe5OiYZMBu6uOFKFbhizsMy4eTkEhtVb4ZzQCucZU7p6z3Mi1PGZyF/9db/3T6A1uoWX7iAyWvCOv6Be7gQQUKzJxqNjEhbDj8L2Y9ExGuu/mK+oCjJXSxR+7YgBClkUaMZ3xPOD9QDX25hNEP2A+sk0/niyg86iTaHA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB6812.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(316002)(2906002)(6506007)(6916009)(26005)(9686003)(52116002)(6512007)(33716001)(8676002)(83380400001)(186003)(4326008)(8936002)(6486002)(86362001)(66556008)(66476007)(5660300002)(66946007)(38350700002)(38100700002)(44832011)(508600001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB2085
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT009.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 5836be87-01ed-4d0b-b11a-08d9bef129b8
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YyvcZup6UoH5sj+QBbHoIQiiWwrGmRb78TCR88VuOV0kYl8VurhxLTPTkEsw5RhhxxWhE34EBnMAve/wEysgBPJwiZtZs4VLkl7d0UcxXxSFOqnJVz04U18naRNGIPf2Rn8r+ZUgAkLBKhIShsM/03ZEBvKVz+ju1X3jXLYAunGcOTgo/9pKCkFIugI6IDPuMQQZOgoV5Iwl0jiZvd6iycw3h7zih/oFjLGdLkJZI/uc4GKA7yx++d4jjH0K+VldcN+Hy2lU0WrKvnbsA66LQV07SkJ7z8IloAfRFBQcf+131t+L6LhBk7RK7fevlo+GyvDFojruWobwJlnBSU8E7ewGrRhK0mfWU/RH8JUYtTyE+m8eRzLn/hCHV/9EEFGPtPtv9pObQ8z15uhOaDSlrBh/vLpRewlfpmTeve1mf6J72L7Zt9tkkjiTopybiKrndzw71i9MWh1P4gMguyHbFObnPthBB1ZBZAFM3iOBobboL2UoptzDBC8vbfdEiCp6geRp3jVhdzYB1XDak+WFNB/lzd1UiSAS2RYcc6eFHvT3M5OBwsVkupQs86N79l0GACQ0eKK4cMefqWB0NFE1uPSacVGdU0UVHe+AGxDVzRLymVJ1ZgRBX5RUitazn+Lrl5Nc6+cc4Byhrpx/JVr8eZ6fcPmAtyTbVp/SQdr/27ez9lwc4WXTvZjBy0OIW8n/e8IcN1bdQDEtE2ONZKyTdRnS3rYUT5yuDuLIlEV3bjPmHr2zL6kDBfXIXOsJR6O+jhETIn3llPNsJfqAskFuzQ==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(7916004)(46966006)(36840700001)(40470700001)(86362001)(8676002)(70206006)(6486002)(1076003)(8936002)(70586007)(2906002)(33716001)(47076005)(82310400004)(6512007)(9686003)(83380400001)(40460700001)(26005)(186003)(6506007)(508600001)(336012)(6862004)(81166007)(316002)(44832011)(356005)(4326008)(36860700001)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 11:02:17.1289
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8a04912-e2ff-43d6-8079-08d9bef13131
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT009.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1974
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Dec 14, 2021 at 06:08:37PM +0800, Jiasheng Jiang wrote:
> The return value of kzalloc() needs to be checked.
> To avoid use of null pointer '&state->base' in case of the
> failure of alloc.
> 
> Fixes: 99665d072183 ("drm: mali-dp: add malidp_crtc_state struct")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---

You can add my r-b to this one too. Thanks!

>  drivers/gpu/drm/arm/malidp_crtc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/arm/malidp_crtc.c b/drivers/gpu/drm/arm/malidp_crtc.c
> index 494075ddbef6..b5928b52e279 100644
> --- a/drivers/gpu/drm/arm/malidp_crtc.c
> +++ b/drivers/gpu/drm/arm/malidp_crtc.c
> @@ -487,7 +487,10 @@ static void malidp_crtc_reset(struct drm_crtc *crtc)
>  	if (crtc->state)
>  		malidp_crtc_destroy_state(crtc, crtc->state);
>  
> -	__drm_atomic_helper_crtc_reset(crtc, &state->base);
> +	if (state)
> +		__drm_atomic_helper_crtc_reset(crtc, &state->base);
> +	else
> +		__drm_atomic_helper_crtc_reset(crtc, NULL);
>  }
>  
>  static int malidp_crtc_enable_vblank(struct drm_crtc *crtc)
> -- 
> 2.25.1
> 
