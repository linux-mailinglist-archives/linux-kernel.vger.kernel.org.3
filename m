Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 000C6494BC3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 11:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376304AbiATKbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 05:31:53 -0500
Received: from mail-bn7nam10on2119.outbound.protection.outlook.com ([40.107.92.119]:53603
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1376298AbiATKbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 05:31:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KbsSg6FB9rW5V1MoPpn5s3m39HunPOz4/7NrCzCMcDn7ijJLpafETs0tsofmykS/Pcrsoyq6ACNB70kAl9h451aYqwNkATP3Heinai6Pk2Vzx3CLNlJcDObwobL6UadcsAzhlELleEk00wNt64S6AeI7/p5rUWfOyW50UiY0TxpU+nOLRUMC5XpV18ro4fy9gzan5WuI4nX5PuCLhUrBPGJIyEPJta0mDRxMXKdTweWNlaNGIj6tVcgFNwPBBA/xNXHOgTmxLLnbvVXlM/XaePIPO4bb07z3ha3z/t42qKQnurkZINUcjt8TyFrn235UcEa0GBrC8D20Nt/eMLqRFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DLVgJiqBtDVu+n73vedbFvwM9rTaeenVyScoVllJ+6c=;
 b=a3nXeXKxrC9QJPSbWFCJUtdWtbB1Hro5O0osH2fWaj/nQvK6E4my7xsUKAouyItetB/m6lvuUeZYS6A03l748J7/VbtYIEE5sGHRzkn0EodG/f+vDpwnwqE4yQOiasQGcl6T/OSf/6ZTgX0SSSonG29mVsrjSznrr5Je39tNaIo35m+8u/1S6INKS+yq8UfRaafS2ey0Of7I+2f0N0sYOd47bu3TZywM5tq/VCo0L8bmpyUWr1JrKOBosvxY4JlZ/t7lPqFe/XvBQu6dBex/tXRmvfGhktf1RQnFW0QjfDhILArqtaz5OzgwKjJxDp0UqirwI90z29WKD/OQEOccsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLVgJiqBtDVu+n73vedbFvwM9rTaeenVyScoVllJ+6c=;
 b=doeUo5BT3sG1TOJ771NHLSrjDteq0eXQt+6SOl+zhUeB0jCJQYpJ52FDqEjqx7nqtCM4/tkzkSG48i0dAsbe2Eemzec5BqXS5jSUQEjESZ+Orb3QT3INl1opPo9qBCfbK5ZalaJRw4xvU6iqyv/GfQmRI0UshU6Rml0PANpVdI0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by MN2PR04MB5887.namprd04.prod.outlook.com (2603:10b6:208:3b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Thu, 20 Jan
 2022 10:31:42 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::8c2c:1b0f:8516:a941]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::8c2c:1b0f:8516:a941%7]) with mapi id 15.20.4909.010; Thu, 20 Jan 2022
 10:31:42 +0000
Date:   Thu, 20 Jan 2022 18:31:37 +0800
From:   Xin Ji <xji@analogixsemi.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 2/2] usb: typec: anx7411: Add Analogix PD ANX7411
 support
Message-ID: <20220120103137.GA2026944@anxtwsw-Precision-3640-Tower>
References: <20220120093615.2026590-1-xji@analogixsemi.com>
 <20220120093615.2026590-2-xji@analogixsemi.com>
 <YekyOVAjI0EE7VYz@kroah.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YekyOVAjI0EE7VYz@kroah.com>
X-ClientProxiedBy: HK2PR04CA0050.apcprd04.prod.outlook.com
 (2603:1096:202:14::18) To BY5PR04MB6739.namprd04.prod.outlook.com
 (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f97d7f83-9d15-4ae0-a9eb-08d9dc000cc9
X-MS-TrafficTypeDiagnostic: MN2PR04MB5887:EE_
X-Microsoft-Antispam-PRVS: <MN2PR04MB58876BD456CB13896A14ACCDC75A9@MN2PR04MB5887.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:510;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H0cWC46PYK2hfIp0GEeAlnu4qMH03MkW/0MmRnVRQKbl4pzccy7InnmdyVhZA365mf2hyWGjkmySLK5bBIXMlQniTt43zoXsKp4Rbd8SQHayYmjcMZemw15NwO0C+Et2VhBkJ3JQNje4kqzMXlDbbWubLx7rk8NjnWB2RK/CcZYBCKEQp7iO0N5CJo3PLeFAV3Oz5ewLmodsUBfCzBwHGJK0FcCLBqJUp2SRVgEuJlR7vCkt6AxNkrnzvQNk6niRiCF6/uKKXO/UATryfPzn2RLeSe95l6h/T1jIz1+VwQuSjS9juqHsF02pwEr+E5l67ukkmuFZKQ3Cb8jkcAYafwKLz5bF+wlzjHNhzup2tPfyLjgzyZTdrszoSKHe9CpyMl1zaCpEFUYaaBYA0CdXR4rmUSCNsruACAzl/W6gEHZurqQfTMAwaE+6ygvxgZAaKNO0QqzKM9AegdH3BswoH0Wke0LSuEb/Wd5UwftPCJcf1TLgdTFYbH1HizSGKLwiKDuRSmoFJhV6yzwZk+Kz8A3wlGdkBck5JQ7mPvOASwy3yxn+0SF5/OM8Y++IPoTKJlprindczShxtsS1s2GicSspKELd6YB4OujLc0IiHZqvlMltyX9ZKRdt578FpYumGM+LQupwvm4V6OAYK5jmk4hK5ubcAVEfrKupG4f0KwuLzr3AyRc3jNpK6ybD6v121muw0ntSOiHA+K9hNsY1T5VwoIKxEx0rnT6wieZbubWtvCvBcGrkr5KBurubP7Op67muHx0P2UkARcNUnDeyXFRgyol89UNWragRPM5LnzE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(9686003)(8676002)(83380400001)(55236004)(6512007)(86362001)(6506007)(52116002)(38100700002)(26005)(6666004)(966005)(8936002)(54906003)(33656002)(2906002)(38350700002)(66556008)(66476007)(1076003)(316002)(5660300002)(4326008)(66946007)(6486002)(186003)(33716001)(508600001)(4744005)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o59ir8ZKadhKk2NxNlT1EBM8RjUc6FHbMGtB4mewvrqK3NunMxtDD7sFfDLH?=
 =?us-ascii?Q?xzbOrmOZan2H4GAmEqclrCStL7nwXB4y3cLvIk2pclRMT2q4Ryrj+M2zzoad?=
 =?us-ascii?Q?S2QOu+Qg6EJCcwV7i7ENH6Dudt0U2W7tktkrlYuNURi8qsc0viMQBiPhGsrv?=
 =?us-ascii?Q?ddzpeHHF3rPlSGZQPN3Q08rvyh2YXq1sIPgKGBxRRllcpVDXNnEWw9VCtt4N?=
 =?us-ascii?Q?Z20owlVPY/N+W7YAIs7oOLK0y840BL1xoibGXdls+yAC8AEzL2cPZ6koWSwM?=
 =?us-ascii?Q?vS4ThfE+Cao1n9/M0kLJEtTzajpVnXo9y5wf2LEDkNQ9I9xX/9HRu1uuo6AV?=
 =?us-ascii?Q?kK6mVxOG8bDS+jo+zRj+FK6JRx1j/4VqTyuy9Hghk+MSK8mkfI6iR5jJhJig?=
 =?us-ascii?Q?1wLvEFG64b8bsmmbBvsGgn4WNmEEzepN5D93tzCqPmU3t24LGQS9Wz7XSMwp?=
 =?us-ascii?Q?uCuqhE0Qmjcisook1Z3/J71p528xaPSEfWe4Zca7TNmkvDMGHmw1zr8lQdfL?=
 =?us-ascii?Q?OoINOZX774n0pkdfg5ya2jmeNEABeQuEvM1VLQwwgDAx/KDauA2A/2QD7waR?=
 =?us-ascii?Q?YrmMcqe+nbk89W27UPoqMeW60BuhkRiZFUyq1+HwWyDV34r68+G8L5mn6a/t?=
 =?us-ascii?Q?5S38ABeeRLGFcBg0yk98p9uW1GM4vCqloS1ZLT3U8X6kbYyEQ2hk7EndBBuU?=
 =?us-ascii?Q?xWZCoY0bpalq9IteDYyIDueG8b9fXivfedTRWN8kBdMKgG5938fmBUgLcngQ?=
 =?us-ascii?Q?sEtTeo7THdA91atrdLPs2mVWwrY4lfpixJ4jTWAVEFG7jKiCeLbOI25tlFz4?=
 =?us-ascii?Q?h8pISzzpvv4t0Su3CiYuaeSVEke+lgatwYeQuZgHj4uUSUJSAohCE4Ye5i0b?=
 =?us-ascii?Q?9L4shHdJ9cNfTWBHzs4nFEiOKFSUsTK58mzfBRQHggFLVQiRSTrFcLQQbgdk?=
 =?us-ascii?Q?QqrCOu5r1qjTO9vupf5nF9YDQI7rTWtWaI2IDhKb1nrbPlHA18SCXRb3eys5?=
 =?us-ascii?Q?eXlj7FsKZFSM3H/eHKowYJaGL8CXZzZ4hW0rtkuHi0D+XOSrt3wL9TlieH7j?=
 =?us-ascii?Q?dIaRG53FhmFZB07ILjIZ31VaXBqhlEvMkY3t3E8K3TquLl7zVTxIktO7nGpb?=
 =?us-ascii?Q?Ax3TirS+LSp7WPJXOyTCxAg83l5DQBFxA/x31Bf9FGS/BuBeRx4wCwV7rwVr?=
 =?us-ascii?Q?+iGFNSYS5A/pWH9KyWQjCNopVOPp/096I/yDlZETkIMqF3dXvKxILyvdoHXF?=
 =?us-ascii?Q?UUliVhMNfkjKyN8kQA5w2oZxaVPa9eZWCtzZhwuRf8N8jVah0nNsQEVCtmKm?=
 =?us-ascii?Q?GwExvkW7zcZXKobsmtV/F3z7BHMUNz25t8+eNFiTYPJArFBd3k29h6QtEDqQ?=
 =?us-ascii?Q?/gmNEPzRkoDlszCNvSq13Lyldm6bxOsfZiS4+oNpAxd23g5ftVc6LNC3UVXU?=
 =?us-ascii?Q?ddhKpoi/l7aDaXXJMhVEDR5mngzJszYyClgSTq9VrE/Gc/ND7UbuVvlghUJo?=
 =?us-ascii?Q?jIwJDc9o3KBFngomxT3HyJMYN9Y2DLLVp+/H8zVI0Xl9ktXufU5pmS4gXUdO?=
 =?us-ascii?Q?dpIyXhcYsnH1TLkScTiMrzbXy0E2wzowipBkOFoq/V3pdCzJH3QGbWIxJka0?=
 =?us-ascii?Q?Q/GbaJPzofzLCq7BCr350k4=3D?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f97d7f83-9d15-4ae0-a9eb-08d9dc000cc9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 10:31:42.4945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gp2IRlZ+evDoaMibe1lPvhbHaLByCjFjN6EocBI9IyzKvO0Ons6E9UlD+n2mD1rJ/1sfofD9EfKb2Y+YkUeYIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5887
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 10:58:17AM +0100, Greg Kroah-Hartman wrote:
> On Thu, Jan 20, 2022 at 05:36:15PM +0800, Xin Ji wrote:
> > Add driver for analogix ANX7411 USB Type-C DRP port controller.
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> 
> The test robot did not report this to ask for a new driver :(
Hi Greg, test robot ask me to fix the compile warning issue,
https://patchwork.kernel.org/project/linux-usb/patch/20220119110141.1020452-2-xji@analogixsemi.com/
so I think need upstream v2 after fixed the issue. I'll remove the test
robot tag in the next serial.

BTW, your robot ask me to add more log at commit message, do I need
upstream v3 after do that?

Thanks,
Xin
