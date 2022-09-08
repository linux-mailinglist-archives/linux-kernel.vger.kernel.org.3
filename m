Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4B95B15B0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 09:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbiIHHbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 03:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbiIHHb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 03:31:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6B6B5E52;
        Thu,  8 Sep 2022 00:31:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2EACB81F78;
        Thu,  8 Sep 2022 07:31:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F2C8C433C1;
        Thu,  8 Sep 2022 07:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662622261;
        bh=NQTjEWGj0+q0xJkhlC7PTldWzfx7HMigsMwJLqoPBCw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NqRLou690lO4LPm/JvT5zgrYf6vos53z2RGQSRGMELhujBXrKK2sUfyy6Lkpwc7I0
         Hx0EWOPU7nMKZuQmCivdJUMyfSVUn/xn+18D1rntIt6NaMPNlhxOiyoXnbs9AD9k/q
         anEUc87IoZKZI8pwsZkd6Y6pisYPib1qqpdcC6i4kwE72FLJz7Fmj3yhEYbldrSzH/
         uMdqGRzUPW5qRr20Mi0EjkgHXRwdaQQwhfqWIiThPVKA/rt28J8qDxuthKlmnnJ0dn
         ie4xpazLWRzWoRfIAuUT/4ttVjPTlIVB/HLxv49CHS3uWGBlDvCzeoDT8nO9E3dNOc
         gLjhOmJaRGyRw==
Date:   Thu, 8 Sep 2022 08:30:56 +0100
From:   Lee Jones <lee@kernel.org>
To:     Kavyasree.Kotagiri@microchip.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, Nicolas.Ferre@microchip.com,
        alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH v8 0/3] Add support for lan966x flexcom chip-select
 configuration
Message-ID: <YxmaMFdprHKMNmr7@google.com>
References: <20220708115619.254073-1-kavyasree.kotagiri@microchip.com>
 <SA2PR11MB4874435AC1CAEE6DAFC3F239927F9@SA2PR11MB4874.namprd11.prod.outlook.com>
 <YxYN9CacFm47R/e2@google.com>
 <CO1PR11MB4865D594CABE612A0FA93CEF92419@CO1PR11MB4865.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CO1PR11MB4865D594CABE612A0FA93CEF92419@CO1PR11MB4865.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Sep 2022, Kavyasree.Kotagiri@microchip.com wrote:

> > 
> > > Hi Lee,
> > >
> > > Are you planning to take this patch series for 6.1 or Can we include them
> > through arm-soc pull-request?
> > 
> > I don't seem to have visibility.
> > 
> Please find the patches below:
> https://lore.kernel.org/lkml/20220708115619.254073-1-kavyasree.kotagiri@microchip.com/T/

I need patches in my inbox to apply them.

> > Have I Acked it already?
> > 
> No. 

Then please submit a [RESEND] - with the full Cc list this time.

-- 
Lee Jones [李琼斯]
