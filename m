Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D664E695A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 20:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352957AbiCXTdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 15:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353001AbiCXTcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 15:32:54 -0400
Received: from mail1.bemta33.messagelabs.com (mail1.bemta33.messagelabs.com [67.219.247.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37DDAD13D;
        Thu, 24 Mar 2022 12:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenovo.com;
        s=Selector; t=1648150281; i=@lenovo.com;
        bh=X6mMeTD2db/dUgjU9YiJTDAvY4WlyZYi+gB5PbHYhjE=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=1CntY7U05/OVQ6nkDog4vGWnay/Xm36nZOnIejxWmJsiunSe1UJ+j71+hEJUOwMrT
         1w1ZfT33TSJ2In3SUhHE2+oxpnupAoA0Rndd1XgJRE3rwEegm2HnW5WusvbkhwTp/d
         NB/jGpK6eT4grUz7mluDga+rqZykGzYHhLQIbydjpl2lSJoCuxLW/brF6dQOtIQBsD
         hjru+FF7/OeLPqMMSAJ1KQJxkH88lsO6ahVFechp6ghUkL00dZHC4+6K8YBI7jlGP6
         FALJxH7mPRgrzhU9taaMwfeFU2vgMuKumXoQgi0klwAWL/hyxiqWmsV6zAfgeuXVxN
         cqH/GJsYIJjhA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFJsWRWlGSWpSXmKPExsWSoS+Voctx3Cb
  J4NNWMYuDRzayWbw9/pTV4s3x6UwWl3fNYbP43HuE0eL3j2dMFgemTmO2WL3nBbPF1r1X2S1O
  7y5x4PJovHGDzWPTqk42j3knAz3e77vK5vF5k5xHf/cx9gC2KNbMvKT8igTWjJUvPrMWLOGp2
  PH3PFsDYx9XFyMXB6PAUmaJDxMOskE4i1glHs//zg7hdDJJLOqeCZTh5BASmM0k8fBrGUhCSG
  Avk8SlEx/YQRISAscZJbpXuUMkOhkldm/9wQbhTGKS6N/wjgnCecIo8WpCEyPErHuMEtO7okB
  sXgFbiWlrnoPFWQRUJebMP8QCEReUODnzCZgtKhAu0b1/PyuILSyQLnF8ShvYamYBcYlbT+aD
  LRAR+MsosWP5XjCHWWACo8Tm/vvMENvSJB7t3QXWzSagLbFlyy+g+zg4OAUsJe6/TYUYpCnRu
  v031FB5ie1v50C1Kkv86j/PDPGnnMT77Sug7ASJ5ilHGSFsSYlrNy9Aw0JW4ujZOSwg4yUEfC
  W2NnNDhHUlrq/YDVWeI3Fhxz52mJGnes8xTWDUnYXk5VlIXpuF5LpZSK5bwMiyitEqqSgzPaM
  kNzEzR9fQwEDX0NBE18xE19hAL7FKN1GvtFg3NbG4RNdIL7G8WC+1uFivuDI3OSdFLy+1ZBMj
  MNmlFDnI7WDctuqn3iFGSQ4mJVHeN5tskoT4kvJTKjMSizPii0pzUosPMcpwcChJ8HIeAcoJF
  qWmp1akZeYAEy9MWoKDR0mE9/RhoDRvcUFibnFmOkTqFKMux5Vte/cyC7Hk5eelSonzWh0FKh
  IAKcoozYMbAcsClxhlpYR5GRkYGIR4ClKLcjNLUOVfMYpzMCoJ8/qBTOHJzCuB2/QK6AgmoCO
  e/7QEOaIkESEl1cC01EKr5Mv77+XzuW6avtbs/ODWGHvXzP7Ojdc9ho1q8X0ZbQZSbO/0iz+0
  B5Zp9zx5I/7r8XmOiTfSK+0P1bvt/aJX7rDD74Pfs1urOqfcN0uT+LV+3jnua4v9DoTnLtn/i
  m/awdsPn3BGOqdNef35a+uBhgt3P+k/PJjj9PVV0vxEq2sfb+/uNwv9fPdt8Fm1KA9xt2+xv/
  9UmVZ/blX/Zfxst9Ck7qCnK4+G255N6/D/tp35w2UffpVz21aW/glcVnOnPiZf3spLiOls2tl
  DSUI3S95G8l+fVH1I/NXrBxrtr6vP+fBf+Jy152pf3SadguNVL48X1q9Pjb6nHpVX8/mQ0FHD
  zTv+NGZPYrbJU2Ipzkg01GIuKk4EAL2Vs+h9BAAA
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-12.tower-715.messagelabs.com!1648150278!39018!1
X-Originating-IP: [104.47.26.104]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.10; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 23921 invoked from network); 24 Mar 2022 19:31:20 -0000
Received: from mail-sgaapc01lp2104.outbound.protection.outlook.com (HELO APC01-SG2-obe.outbound.protection.outlook.com) (104.47.26.104)
  by server-12.tower-715.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 24 Mar 2022 19:31:20 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gbQXxLoMeSRbJLgblJHoMmJ8dtebcAsO0Q//OTXChklkamBwOTsDDE+zwN+AIeyoGH9ZIb3SBJ6jL3bIlkoigIlJ7bqmGHl0oax7xfkLrKJddF3ndEBxOQEU5BeE2DHLkM+yCReLnCR1MzFe0mJHfE48kQl6/ZZyPVBDDBfBxRcNoeLWjlcK8yEdoDtSmPTvgtyXvbywm9yc5aT5ISQAM/laGZR9n0DgaMeApJyADMeCiq2X2Dzjk7/mtBQv8/yFcPfUz5t89w28lpjnW71baAqh1nq+eY0x32k8bhLk2y++PrkDUbYLFvwjL0Wtf/ZNcl2tqeWlnGrXIYZ10N7tmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X6mMeTD2db/dUgjU9YiJTDAvY4WlyZYi+gB5PbHYhjE=;
 b=YwHQsD55/B8QdDMmyVvMysdx7cX9JhaVTEVnbRWYAxkYyOv55ieAZkx4FwUM32c938t2Bd9hXLiHAVgmyvNVifaNI2kjl87fUwQ0jV2dj8FXk/CXB/lgawLg2rt7aEnnZRquR7Tg+IUobucMzFNjN6LMJR+8PeiSdlF8W0AZGKNaBILBf6DYXaPdErDSIWQjdc/sqItGNI879qa40zLHPDxAoJVYUJuYoOdcyiVah1UvALGJHPx+4mWLjm64iIa8JRszyyzPU6QadGj6PY3CHNTRF37jHPA6ZH4n0vYSoDLvr38OUSfNTujmsf1K8nqbF5+B1OEwBv6/TqjXWXHLww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 104.232.225.6) smtp.rcpttodomain=redhat.com smtp.mailfrom=lenovo.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=lenovo.com;
 dkim=none (message not signed); arc=none
Received: from SG2PR0601CA0023.apcprd06.prod.outlook.com (2603:1096:3::33) by
 HK0PR03MB2978.apcprd03.prod.outlook.com (2603:1096:203:4f::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5123.10; Thu, 24 Mar 2022 19:31:17 +0000
Received: from HK2APC01FT016.eop-APC01.prod.protection.outlook.com
 (2603:1096:3:0:cafe::4f) by SG2PR0601CA0023.outlook.office365.com
 (2603:1096:3::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Thu, 24 Mar 2022 19:31:17 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 104.232.225.6) smtp.mailfrom=lenovo.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=lenovo.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 lenovo.com discourages use of 104.232.225.6 as permitted sender)
Received: from mail.lenovo.com (104.232.225.6) by
 HK2APC01FT016.mail.protection.outlook.com (10.152.248.193) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.18 via Frontend Transport; Thu, 24 Mar 2022 19:31:16 +0000
Received: from reswpmail01.lenovo.com (10.62.32.20) by mail.lenovo.com
 (10.62.123.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2308.27; Thu, 24 Mar
 2022 15:31:14 -0400
Received: from [10.46.54.2] (10.46.54.2) by reswpmail01.lenovo.com
 (10.62.32.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2308.27; Thu, 24 Mar
 2022 15:31:12 -0400
Message-ID: <e95846d3-e44f-47eb-04f1-2cf3153566c0@lenovo.com>
Date:   Thu, 24 Mar 2022 15:31:10 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [External] [PATCH 3/4] Documentation/ABI:
 sysfs-class-firmware-attributes: Misc. cleanups
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        "David E . Box" <david.e.box@linux.intel.com>,
        =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        Sebastian Reichel <sre@kernel.org>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
References: <20220324164737.21765-1-hdegoede@redhat.com>
 <20220324164737.21765-4-hdegoede@redhat.com>
From:   Mark Pearson <markpearson@lenovo.com>
In-Reply-To: <20220324164737.21765-4-hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.46.54.2]
X-ClientProxiedBy: reswpmail01.lenovo.com (10.62.32.20) To
 reswpmail01.lenovo.com (10.62.32.20)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f324644d-a1ef-4c60-3a1b-08da0dccddbc
X-MS-TrafficTypeDiagnostic: HK0PR03MB2978:EE_
X-Microsoft-Antispam-PRVS: <HK0PR03MB2978AE218E872CAB19B77984C5199@HK0PR03MB2978.apcprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rv89Psxtrh9jRgzd3qg8c0si7j7hZitMpOt607ihBrwzXSw1RTTGTm2xc8IRd8JusyYjt03XxVoCCWCXYlTx5i9bFxIGLPg7JOAc6l/jrJHZjbVIw+ILQvlc5aORtnRBGwLp0dYW5HTrPfARMG7PmS1VamqaE2zPTlk0+FdK7N+WWw1mRn29TQ7OFmvuHJl4V9elzUTNN/ATx1cm4VPQhH3pa/GdGQCC4rYe0sgiHbgrTacgqieViUGfRpFrpuL82ZrMz8NjeSqI6lChRZii0b9jBMOBtrqUnA+R7njJDFJjg+PpQGnr7B9RbLFfFj66IPeOIBwK58kbs+/Tq+tMvclDJpDhlKkGJZ3GprO0l7tisoYE1OcncUKUd8eiJrQEyJ0U+rX3T2NlBGg5xafGwoMzUxl6KxG68PHybIawgrbWOTW0rYLaIDBOSKZ0WTtZjKVvV+3aMz2ACLPsD8gpIOES/qSTPe/qBxXxqgBBn2oPybqY+sCg99a0P/jkWQMb3HenrngT/Jg6ftvHEvt/khmk8LT4DSmkFFpeyguffmZoZYEHlZxaltIpfA/h67ZWXkRPNx7rredalqHCvK8ZiyZhR+ghBVjgziqMH74FJ3CGyAnHIbiL9AFzHvx68DzvpapTY+usgdE8SL6jdPeoXJcSbdpORIOuXGUivvbf3U0lUGFFbvlkO4u08PBNoaXYTSO0Nd1WxsC36jO/EDY6L+EkA3yldRIXdqUpB5m9fluj8VOxL9biFtLsLGlnhJgd7Fipi3JNlqJW8Oq1v7b9ta3P/EWHzdJS/46zDWTPIheLysCArmS88eCOmwF8sUhz
X-Forefront-Antispam-Report: CIP:104.232.225.6;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.lenovo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(2906002)(508600001)(70206006)(8676002)(70586007)(54906003)(31686004)(36756003)(82310400004)(31696002)(86362001)(110136005)(53546011)(2616005)(316002)(16576012)(40460700003)(36906005)(426003)(336012)(81166007)(356005)(82960400001)(83380400001)(47076005)(26005)(186003)(16526019)(8936002)(4326008)(5660300002)(7416002)(36860700001)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1102;
X-OriginatorOrg: lenovo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2022 19:31:16.5624
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f324644d-a1ef-4c60-3a1b-08da0dccddbc
X-MS-Exchange-CrossTenant-Id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5c7d0b28-bdf8-410c-aa93-4df372b16203;Ip=[104.232.225.6];Helo=[mail.lenovo.com]
X-MS-Exchange-CrossTenant-AuthSource: HK2APC01FT016.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR03MB2978
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/24/22 12:47, Hans de Goede wrote:
> Cleanup / fix some minor issues.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  Documentation/ABI/testing/sysfs-class-firmware-attributes | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-firmware-attributes b/Documentation/ABI/testing/sysfs-class-firmware-attributes
> index 5356ff2ed6c8..4cdba3477176 100644
> --- a/Documentation/ABI/testing/sysfs-class-firmware-attributes
> +++ b/Documentation/ABI/testing/sysfs-class-firmware-attributes
> @@ -116,7 +116,7 @@ Description:
>  					    <value>[ForceIf:<attribute>=<value>]
>  					    <value>[ForceIfNot:<attribute>=<value>]
>  
> -					For example:
> +					For example::
>  
>  					    LegacyOrom/dell_value_modifier has value:
>  						    Disabled[ForceIf:SecureBoot=Enabled]
> @@ -212,7 +212,7 @@ Description:
>  		the next boot.
>  
>  		Lenovo specific class extensions
> -		------------------------------
> +		--------------------------------
>  
>  		On Lenovo systems the following additional settings are available:
>  
> @@ -349,7 +349,7 @@ Description:
>  
>  		    # echo "factory" > /sys/class/firmware-attributes/*/device/attributes/reset_bios
>  		    # cat /sys/class/firmware-attributes/*/device/attributes/reset_bios
> -		    # builtinsafe lastknowngood [factory] custom
> +		    builtinsafe lastknowngood [factory] custom
>  
>  		Note that any changes to this attribute requires a reboot
>  		for changes to take effect.
Looks good - thanks for taking care of this
Mark
