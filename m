Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED2BF495877
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 04:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbiAUDGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 22:06:10 -0500
Received: from mail-dm3nam07on2102.outbound.protection.outlook.com ([40.107.95.102]:63265
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231283AbiAUDGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 22:06:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NRxwn2lgfBDQrp/9jw9Adw/LKPKw799hd63FTBwbqHxSmpR2bDktiRuwSUbocCR6f7HZfNdmu1y7OwkAGAlgbPy+sJpHa8QMBXBEmByONouZsvvbyn4WFpU+RVT8meY65CJXKS2IVRwoRDwKqJZwWme7k/X9v2F4+q8sf/8SGaA0CT88YYTTohRlM4n+Mo3nqnR4YfM/ug9ZhhjvK0w8islAbmM7LOA7V8LwFMRnuGQqIoWhv11ezt271MFYsUdfwesOG8M4VlErRQkyxB9BEx/8gZbRNtUKZM0EvsMVaHXT61+ECYZ6eVaVdAzQRVVkvpi1c8NxKR9eM9GMJXeEKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MwuqnJJw8Z6RlgCqjP1t1RXSNCwpNtlAVRob/w3bxeg=;
 b=gB6GaLlvOeuCgBtyI2sR4MsfLAC42mhySYIbAFEHVBW2djzUja9b0hqn8QniaKYSxo2YYvT2DweU31YUoXH6KMUjutAdsriPYL/AgwPBAEdVRjSf02cYsPBSzZdRteQgcivti1trAh3KqlpfQRotuFe7RtfakYvTrq2N461mj+5bZGyHEncmOgQBO4IeEUwrkkp0Qto6W4d8097TLo2YUaoLkqR7uwpHQw4Dy8fV1CisBpb5lqmprm4btd3uY7CgbDg2xkyd3KhRUYFnBvTDFRaCU/1b6DO6fLyeYCfsqb2n2V8sswEE5x5zXXxsXFSjIjpL0NhQYbmPAY8wzKjQ6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwuqnJJw8Z6RlgCqjP1t1RXSNCwpNtlAVRob/w3bxeg=;
 b=jWrNQpRU4FWD0BVvT4im0sm2b4NmNuD3randyIB2ELPEd4vLnpFCYV2r9rGyAskICrC2N+tcDmFLwYlUMMbRCxQvI2M/M9R/tkasjriy8V5pHO8+nbEAco/ZRb7SNYunybxBoXo2Fb/sMDlyTjONejuJm5zZldH3YAJpE88dtYI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by BL0PR04MB4530.namprd04.prod.outlook.com (2603:10b6:208:4d::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Fri, 21 Jan
 2022 03:06:03 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::8c2c:1b0f:8516:a941]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::8c2c:1b0f:8516:a941%7]) with mapi id 15.20.4909.011; Fri, 21 Jan 2022
 03:06:03 +0000
Date:   Fri, 21 Jan 2022 11:05:55 +0800
From:   Xin Ji <xji@analogixsemi.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 2/2] usb: typec: anx7411: Add Analogix PD ANX7411
 support
Message-ID: <20220121030555.GA2034002@anxtwsw-Precision-3640-Tower>
References: <20220120093615.2026590-1-xji@analogixsemi.com>
 <20220120093615.2026590-2-xji@analogixsemi.com>
 <YekyOVAjI0EE7VYz@kroah.com>
 <20220120103137.GA2026944@anxtwsw-Precision-3640-Tower>
 <YelNrzuYajCZ7agG@kroah.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YelNrzuYajCZ7agG@kroah.com>
X-ClientProxiedBy: HK2PR04CA0058.apcprd04.prod.outlook.com
 (2603:1096:202:14::26) To BY5PR04MB6739.namprd04.prod.outlook.com
 (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c654477c-844c-4a4f-1975-08d9dc8af50b
X-MS-TrafficTypeDiagnostic: BL0PR04MB4530:EE_
X-Microsoft-Antispam-PRVS: <BL0PR04MB45304E6F21E9170445D97C1BC75B9@BL0PR04MB4530.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:597;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TKwgoRRmRSAl+Rh2uBnR0Kqpuku71zd4sTKVPns7ncM0dQt4RCyQjBFPzvGZrylCkrqSPZ4vW9BqZySANVci8YYq8ZgDS8vLFR18fKBZSXjnF6dp/Z3fbDJ0bnNgL2pAZ2GH5MDeR/j+2oRNfx+KHzhhLTVk7eUMh+LMYNWmtcZm3m+70KkXK8cvwS/l0GRIoUdG/m5fGzXUuWzJHoZSh7op6pGHrhNrsybvwLcT+06Xa2rA1H6HExJoHfMhtfpONINTfn1Q7yrYx/YfZkyjuvSm7nvvy8cqWKqVxyoK8dwdQxONCb5dgdRDVgs2ypZ/qzZI+s4oXkAzzLPpvUSj8718cq4ntkQpUfhmMQc7wPbmM+KJ97HL4DjYy4I1R/mYSADqw8jRpF8CIEDlSg64fhDfVJh02xpF8f6y3uHXw7gkaGCywxwCZ54nXtpWCCDAQM9eirqDiSfMUDjjNWPpG3ynsoG7/Dr0wEW3ifniziXeEDK+UjYG1k5Flql9jdbbQvjK5hHtqd2dLykm64KTunbRio8zraTk+j5Lh2TEmfihHgeu1soDZ0kcQirgqRum266fqMGeMUH7PPs7UAeBULfIim1PjKm/BbyDCzqaMAfa6GoBSEEUGtWVQlw7nCQ73/arA7m0KQMxNgaTXmtFFv4GdgUfB7R++LTt2rtZatUQ2WzWAStCWR9IpBdrF0xcGmOOJCD6i5PgZo8X0z0NkUMsl/V4rhlVhwoxco9zrrF0hZbGXt/AeEDvT0iaVJdPfLuyCnn4s4Fe04HdVs++cv44BDRG9WhAobW/LtCbMqk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(4326008)(38350700002)(38100700002)(83380400001)(6512007)(9686003)(6486002)(8936002)(33656002)(316002)(33716001)(508600001)(45080400002)(86362001)(2906002)(8676002)(966005)(54906003)(52116002)(6666004)(66556008)(66476007)(66946007)(5660300002)(6506007)(55236004)(186003)(26005)(1076003)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o8JdV0K/gDElWjsc4sMV0vXbkZClaycrennvCA3d0+qGPauUeHdF5CdbyhJ/?=
 =?us-ascii?Q?DNZ0QhHbuG+/G8Yg2i6OrPTWox5cPa7lO0AQBUKHMb9iUtwCbrxnHGlX9Dnz?=
 =?us-ascii?Q?RfsjpTcBmLC5/gNBkM69kczgEAmhIn6m/9pI5Cif340VKpuC6uqhRUwO9Ksc?=
 =?us-ascii?Q?BYjWYBWOSRrmjQJ3G2ZCa+GfWo8EvRASdumS4fynueW+tmHPd2LC7w462k5U?=
 =?us-ascii?Q?+1ewfBt/e3lk3deIwB+WTALZCy8hgy5dJTVLS8HAVdpq9dArOd4fjvaibMlL?=
 =?us-ascii?Q?p/id+U9CkRZFnPdHSZMKjgs7wR+KY0D1f3PFa06yueH9cfNVejKte/iU+gc2?=
 =?us-ascii?Q?2k+9QHIGw14cA3GW172QJzOyqAnjN1xWfDuogojXZNEQGnOfzKHKNJ+MgE97?=
 =?us-ascii?Q?c04/WQQolijDP6jcHsEdgUqAlmlkEzUDDRZgkBPAWcuh5KTwvXoktkTgh+1c?=
 =?us-ascii?Q?+qvrOiTWy6mf2OJjIMrvSKDvMD8l93sW2p83jrCH0u3rnYWTl5pUjLGThgqX?=
 =?us-ascii?Q?8x7tA6GdldxR4fz0NvVRmzkGfYO9SaIqive+QvbCvoBu0cT67S/JRuEtQ/q6?=
 =?us-ascii?Q?3y4Bj9oDrwb0IKVxuIBu3NDj99zNhnVTxoRcz2bhB8GQHRT6pp9WkcXrNVgA?=
 =?us-ascii?Q?gL/lEeQPybtPPFDced8UKEGAcutDI388lLVn1zy16CiO3SeDGUvBAVZZwV3w?=
 =?us-ascii?Q?5LziN+bTo0Lc303iv5wz0eVdi5F4/0+LbWRDau2wJ8fF+pbnVINGWAlu6csR?=
 =?us-ascii?Q?+mpYEzZ8M8CfwZoWFVnMNw+oHKIKUZfAoDAlzpaGLw6lon+h1voxayAuNkLS?=
 =?us-ascii?Q?Y9x6vFZyOm183CuGhx1K288GPvcFbOrRYd+Et+SZURw0Eb2A841h839P2LjT?=
 =?us-ascii?Q?SqfEwMJCgTLIL8PVXQ4v4GZPC4WFqNgXn2ML6BpuZC5nFW5Kn8DCtpxzLdr2?=
 =?us-ascii?Q?hPEKBfI1T5bLTpBmb/OQz+f9Q1A751IViWiVb15tajM1icKQunudbTmI4Qxb?=
 =?us-ascii?Q?CLz9p0LM3DgamyT0/1Ttn8nLy1NCXSkWENwBX9enrB+wdgq9QrDSwfOuPuDz?=
 =?us-ascii?Q?MO+gZResdIXPYIIsuUd1044iWOTyCYcf3V4LFNmDvpA0xY355q3gPCELgnNQ?=
 =?us-ascii?Q?jvFaoMV/JrI0Z103KtavmQPVQfrSTsHl//fKToUQNBx8qEUPetquZV6taYWI?=
 =?us-ascii?Q?o8oplw2KYPIVIK/9Dl+sh/D3fImhPzxSqZo/46rvF76/YS9s2be6SwGEUzVi?=
 =?us-ascii?Q?qQIUMkFjdTtlDqNA93GctuJLZytauXdnRPROdj39eGS6Jz9jmibDVdZkqoTx?=
 =?us-ascii?Q?MEOu86SKoAAZPI9sM8fnxn2HenYurpB3epI3ctph3RODGi6uqlUbQdUL/Fh/?=
 =?us-ascii?Q?bxN7hkpyz8svW9PH6M8E9/aefjf+bhCISDVTZuIvZ4Yoqn0CpV0iRDP1oTlF?=
 =?us-ascii?Q?PXECI1f2lpk0RSE65yFR9c823V0DIkOeWUUxjON2C8OFaUQvmnczap3yWspA?=
 =?us-ascii?Q?f1+gVpJWCyJVmBMzEIuCaDNBtveplCMIvhRk1qgK8yZxjXlsSTqzkh4qN1fG?=
 =?us-ascii?Q?3mzsMIdt0yAzgKmQVFKXAbhMt5P4/q5pxpXOXaEK5N5des8k1i/0wLH3OuXM?=
 =?us-ascii?Q?aP24aakDme5zYes1tu87D1Q=3D?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c654477c-844c-4a4f-1975-08d9dc8af50b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 03:06:02.8752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gQ56db9bK4eHwOY7KCYCtIeOUrw70PVqddeDMRUZfsqRepRGgZW5RW+wnq17+z0I1WtXHkjbWigHnn8cw7u6Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4530
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 12:55:27PM +0100, Greg Kroah-Hartman wrote:
> On Thu, Jan 20, 2022 at 06:31:37PM +0800, Xin Ji wrote:
> > On Thu, Jan 20, 2022 at 10:58:17AM +0100, Greg Kroah-Hartman wrote:
> > > On Thu, Jan 20, 2022 at 05:36:15PM +0800, Xin Ji wrote:
> > > > Add driver for analogix ANX7411 USB Type-C DRP port controller.
> > > > 
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > 
> > > The test robot did not report this to ask for a new driver :(
> > Hi Greg, test robot ask me to fix the compile warning issue,
> > https://nam10.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatchwork.kernel.org%2Fproject%2Flinux-usb%2Fpatch%2F20220119110141.1020452-2-xji%40analogixsemi.com%2F&amp;data=04%7C01%7Cxji%40analogixsemi.com%7Cd94f0560432b4f5af2d108d9dc0bc41d%7Cb099b0b4f26c4cf59a0fd5be9acab205%7C0%7C0%7C637782765372551598%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=zOtehvul8zxKJgFK3wk0rZtaDDfH41Gc1pADwQV5LkM%3D&amp;reserved=0
> > so I think need upstream v2 after fixed the issue. I'll remove the test
> > robot tag in the next serial.
> > 
> > BTW, your robot ask me to add more log at commit message, do I need
> > upstream v3 after do that?
> 
> Of course, I can't take this as-is.
Hi Greg k-h, OK, I'll updata v3.
Thanks,
Xin
> 
> thanks,
> 
> greg k-h
