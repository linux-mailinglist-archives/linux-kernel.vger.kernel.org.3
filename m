Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAB84740F6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 11:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233357AbhLNK71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 05:59:27 -0500
Received: from mail-db8eur05on2052.outbound.protection.outlook.com ([40.107.20.52]:18400
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233336AbhLNK70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 05:59:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0++1zUP4rBhNfAmc5gcbquat5bz0Ez8A23T93niadM=;
 b=dMCfqFUCnQ7DCswtUgpnP1HAzt8JQGCbpUTid9yCB9qisEIBsUY+PsHTulmJHvSO3bIPgsxDXmM0NssvYFNIufxG2BHm9syBUlxx7pFly68M8dgYBex7i34Pq7NFEV/M5f7ld7LqZErAmjrwKTN28yc6coSXvv7M7S/Uf2GU0Lo=
Received: from DB6P18901CA0001.EURP189.PROD.OUTLOOK.COM (2603:10a6:4:16::11)
 by AM9PR08MB6852.eurprd08.prod.outlook.com (2603:10a6:20b:30f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Tue, 14 Dec
 2021 10:59:23 +0000
Received: from DB5EUR03FT020.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:16:cafe::b) by DB6P18901CA0001.outlook.office365.com
 (2603:10a6:4:16::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.13 via Frontend
 Transport; Tue, 14 Dec 2021 10:59:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT020.mail.protection.outlook.com (10.152.20.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.12 via Frontend Transport; Tue, 14 Dec 2021 10:59:23 +0000
Received: ("Tessian outbound c61f076cbd30:v110"); Tue, 14 Dec 2021 10:59:23 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: ddf12c7751255983
X-CR-MTA-TID: 64aa7808
Received: from 163d9da6a332.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 6DD672C9-1834-468C-B916-3F9E4E0F8A09.1;
        Tue, 14 Dec 2021 10:59:18 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 163d9da6a332.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 14 Dec 2021 10:59:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TuKtQEHrznrMTs5c6Yc+ufj/hyx0WRwEEC6+16N1qLmj0QQAe62oUgdJmdgpKLGvJ9/SBW7IciPBSDgwol8beGQHffWWZIkpnEhL+9TKCt3HrA29l0D4AtpDnnmxO4kLHYjPoMn7NWNVPwu9fxkQl++g3dao0l/fe2EWeLnu8Rwt4zbt16z82jIzdUBbs0m0MNBg52+3H8WyGu7QAPLxrHhcIQYKX8r8ywYmVLkdz8w6TAz0+lNTIRV9Zt++3o8DXyzXXHVOmWdYhUmzokWqTygB5amrftPYa0KUroKRqKJJzX6ceqtCucy/r1NCYeE8dLOXTpG7hO9Z6QKv/xP8xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L0++1zUP4rBhNfAmc5gcbquat5bz0Ez8A23T93niadM=;
 b=TgpTltiMmkGYCLWCbIq64r8qruTSqz6J1l8LqEqhUfWXqF3xXHt1KCK0q2UXTGw8cJkdhmjvz9iljN4F7IhtllKDLTFFugk9QIUd9wFNJsorILv+taMAjJVNIDiu/d/i4n7s61AnebNRwdame9p6NSFksKDnEv789nnwMr16jRDMdYp5w5Q3qKfPeygfEpupvleAFp0xt1Wn74GqAEP/gYlF1IIoXeTTvdqxGHRGta0ZGHc1ZBOuTB+TeInwGr3yH9g9+HkN9Ix/hSI2+n1g/nYJwac7OFOWeAlVyRTbr1Z4vuZnLa5DeSDpBPQrVAOVUez47EwIEYt0cBVcE2KpzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0++1zUP4rBhNfAmc5gcbquat5bz0Ez8A23T93niadM=;
 b=dMCfqFUCnQ7DCswtUgpnP1HAzt8JQGCbpUTid9yCB9qisEIBsUY+PsHTulmJHvSO3bIPgsxDXmM0NssvYFNIufxG2BHm9syBUlxx7pFly68M8dgYBex7i34Pq7NFEV/M5f7ld7LqZErAmjrwKTN28yc6coSXvv7M7S/Uf2GU0Lo=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB6812.eurprd08.prod.outlook.com (2603:10a6:10:2a2::15)
 by DB8PR08MB4028.eurprd08.prod.outlook.com (2603:10a6:10:a8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Tue, 14 Dec
 2021 10:59:14 +0000
Received: from DB9PR08MB6812.eurprd08.prod.outlook.com
 ([fe80::fd1d:c45:53d5:79eb]) by DB9PR08MB6812.eurprd08.prod.outlook.com
 ([fe80::fd1d:c45:53d5:79eb%9]) with mapi id 15.20.4778.013; Tue, 14 Dec 2021
 10:59:14 +0000
Date:   Tue, 14 Dec 2021 10:59:10 +0000
From:   Brian Starkey <brian.starkey@arm.com>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     liviu.dudau@arm.com, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        nd@arm.com
Subject: Re: [PATCH] drm/arm/mali: potential dereference of null pointer
Message-ID: <20211214105910.zwmrgcaswgrtnb5t@000377403353>
References: <20211214100000.23395-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214100000.23395-1-jiasheng@iscas.ac.cn>
X-ClientProxiedBy: LO4P123CA0367.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::12) To DB9PR08MB6812.eurprd08.prod.outlook.com
 (2603:10a6:10:2a2::15)
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 8409414b-3d67-4ded-6ea3-08d9bef0c9e5
X-MS-TrafficTypeDiagnostic: DB8PR08MB4028:EE_|DB5EUR03FT020:EE_|AM9PR08MB6852:EE_
X-Microsoft-Antispam-PRVS: <AM9PR08MB685254B73C8B59446140A8CFF0759@AM9PR08MB6852.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: uJ5TT/YH+MAhT6wgi3w+MfxpxTh1+Q4pOILrx/BuYKfXPvzRDdk2kFeyf8a6bkK/66FknfequgBdJ7IzkXTTt3jE2fk32mwNZ3Xi8bNTRiL3l0K0/3lVbA/tK88fehADXndzRBEZKNbefGzT25lbj8HtiSiYsP2PK+3jBo4bvbNn4NS9I6n7ZvhNv4TrKWjEssxYgNQtHYtYhBCPW09nPIvcKkO18Cx+arXYXZxmFBdQjcvBhqSw5gDjx3n+Q2G4CBmqv5GBfW1q0S2MqqSEjV6JlAEO70JWC8QC0ovjzadvslz6o9JzfY63CYj+E3O15ZE1nF8BjG67hmypvEuIAlRsk1iR9QzemimBYz/WXkcHu57OvnUfqjVrspvSczhxr99sl0eMKHIe5yqkwsggXJbx840IfsajCzfXpUCNwIY1tLaQu/lPFYMsIOOon8GlGN9oEPZ8Hjx+gmdHuK9nmjT40mS/z+/6mjqXcuCQm63cQO3RRqd1nO3SbuwzK2eJp9ndKKlEmXRRuM67edkbXQkpPVyJ9yTxG0Ix68gSgubXSe3HZ6fJLldqkVTfb4NnehRTQV6CDHKCEZcwIleF+tiGQ5jG3ox5cwJs9R6mZ0OBKkjW9Gqyzh9dYI5K31gpa1FruZ6KNd+9T9Fhu2G1unMw1vPptezkgEKbyyzS4GgMWssoX6bzTwon6oGmKiqp09GR1WMrAQUL0KcX3d14Ww==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB6812.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(6486002)(38100700002)(6666004)(38350700002)(33716001)(86362001)(83380400001)(66556008)(66476007)(508600001)(66946007)(186003)(6916009)(316002)(2906002)(1076003)(44832011)(52116002)(6512007)(26005)(9686003)(8936002)(8676002)(5660300002)(6506007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4028
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT020.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6a1534bb-1364-48eb-7d06-08d9bef0c417
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QN4iyyzs8M27wQs8paIl3izo0ErDRZ4Q1RS/qB0UhCRbAsObxDlMYBugBHUyr72GClzV7U6gtCQUJaH0HqYPAKRG3s0Zn1aZjzOQ7sKF6qKd/gRhLoY2xHcdaVcNeUIKAi6GHou2SQmr3vxyJiKErYZwWIrR8Zn/PkpqCSOG+mgMXOGBx2GAne9cA0wZLm07+sv/+GX1ZRHeCPbPtbIGUxRiuuWJYXg1+X71i83iHYJxJTBRyATPl32mEfUTCW40uC/kcdPyE0Ghg2twUM1Xo8lI4D1lOiurXJVz++SAZEZ7Ea9BQelRu7x1TQMoJTJFNv2OscRqU7ohoNMOfH7BZvMCAJ2Vh/O39DQJPSbgDgqK00K60d0Y/tBEyTmhFHdLtZHuZQV/MrLI+bpeiH4dzj2X5i+sybQEYUxV8PeO7LFj4vsGQjL4jj3/75834mEa5WLDUJUH9QkxuzBXtjAQdkmCRk4XWstt8CNgL0tIKlXmhQnzOFMxfqk9shP0YtwU21Ju3yfCr15rYzQHnA3NKMJk6trEYz75cmjL1aF0MOL1sVn32072vaU9h8pef/GHWdkEKSsOAsGRKv3OzBhYJQ0iS9dFBfDclS05AHAiP4dOpcl0nkLv5mYYz83KGoOYEM5EBa6CHOIJ3pGS4rW8TwEOEDXRrtYkpWbMFy7T5J/88++5KJaTxjkFkFITRO5K1TdvIxQO9xQT6bEIHLUKY/6LjR8DI/6x/kT3BTWWHulUzJ7VqpNJ3x9pPMsxsN6s/SfSKjoVtaJQRXjZGcVQcA==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(7916004)(4636009)(36840700001)(46966006)(40470700001)(9686003)(6512007)(6486002)(83380400001)(356005)(70206006)(36860700001)(6666004)(47076005)(81166007)(1076003)(33716001)(186003)(86362001)(6862004)(5660300002)(8676002)(70586007)(6506007)(316002)(508600001)(4326008)(8936002)(336012)(40460700001)(26005)(82310400004)(44832011)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 10:59:23.8230
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8409414b-3d67-4ded-6ea3-08d9bef0c9e5
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT020.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6852
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiasheng,

Thanks for the patch, that's a careless copy-paste on my part :-(

On Tue, Dec 14, 2021 at 06:00:00PM +0800, Jiasheng Jiang wrote:
> The return value of kzalloc() needs to be checked.
> To avoid use of null pointer '&mw_state->base' in case of the
> failure of alloc.
> 
> Fixes: 8cbc5caf36ef ("drm: mali-dp: Add writeback connector")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---

Reviewed-by: Brian Starkey <brian.starkey@arm.com>

>  drivers/gpu/drm/arm/malidp_mw.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/arm/malidp_mw.c b/drivers/gpu/drm/arm/malidp_mw.c
> index f5847a79dd7e..612d386ee7d2 100644
> --- a/drivers/gpu/drm/arm/malidp_mw.c
> +++ b/drivers/gpu/drm/arm/malidp_mw.c
> @@ -70,7 +70,11 @@ static void malidp_mw_connector_reset(struct drm_connector *connector)
>  		__drm_atomic_helper_connector_destroy_state(connector->state);
>  
>  	kfree(connector->state);
> -	__drm_atomic_helper_connector_reset(connector, &mw_state->base);
> +
> +	if (mw_state)
> +		__drm_atomic_helper_connector_reset(connector, &mw_state->base);
> +	else
> +		__drm_atomic_helper_connector_reset(connector, NULL);
>  }
>  
>  static enum drm_connector_status
> -- 
> 2.25.1
> 
