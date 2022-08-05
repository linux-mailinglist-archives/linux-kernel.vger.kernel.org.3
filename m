Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34DB58AA51
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 13:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238075AbiHELr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 07:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233062AbiHELr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 07:47:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27B231238;
        Fri,  5 Aug 2022 04:47:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 913C2B82884;
        Fri,  5 Aug 2022 11:47:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35365C433C1;
        Fri,  5 Aug 2022 11:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659700073;
        bh=JMMJeixBs3l9ubdtNRBE7DXk1PsGjT8Uuky1AgfqSc0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ppfklYZLyx6qK75yBrHA6LYRgkcnNugJOsJPgFXVl1oESd225AcOJiQUjBSJErSh7
         Nr7eLrI1Izyj+wsSCjb70hLOIgovFxqfcbnNvRTzIOx5A8JhQukJESNoHLFwJYFN29
         pFFgWqs1m4VUPVbIkEIYLwpj4+tXPBCx1cuwljDLRurGUntZ3gEZUTZfsGEeEtVpM/
         O1IDYP2ShQNUF0bOlWOoSPlbedqgeF+Q6QrldusqfsbIsPh2KszsgCAuUvg2106tvL
         10+x9xMMk09P6Nr+ay6dAmdyupB4+aIim2OtUj6Z9dbOIWB/UvZeCmGi2LmORIWcW/
         nZzfAUgLelbZQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oJvoO-0002Nk-Uk; Fri, 05 Aug 2022 13:48:17 +0200
Date:   Fri, 5 Aug 2022 13:48:16 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Amireddy mallikarjuna reddy <mallikarjuna.reddy@ftdichip.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, malliamireddy009@gmail.com,
        arun.pappan@ftdichip.com, sowjanya.reddy@ftdichip.com
Subject: Re: [PATCH v1] USB: serial: ftdi_sio: add IDs for NEW FTDI Products
Message-ID: <Yu0DgKWYqGim7y3E@hovoldconsulting.com>
References: <ac28f2c5eba23a645b3b9299c224f2755a233eef.1658385786.git.mallikarjuna.reddy@ftdichip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac28f2c5eba23a645b3b9299c224f2755a233eef.1658385786.git.mallikarjuna.reddy@ftdichip.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 03:02:44PM +0800, Amireddy mallikarjuna reddy wrote:
> Add the product IDs for the USB-to-Serial devices FT2233HP, FT2233HP,
> FT4233HP, FT4232HP, FT233HP, FT232HP, and FT4232HAQ.
> Also include BCD values so that the chiptype can be determined.
> 
> Signed-off-by: Amireddy mallikarjuna reddy <mallikarjuna.reddy@ftdichip.com>
> ---
> v1:
> - Initial version.

Thanks for the patch. This looks mostly good even I should revisit some
clean-up patches I have laying around that gets rid of the unnecessary
device-type conditionals that you're now extending.

I'll either rebase this patch on top or the other way around, but either
way I'll get this in in some form in a few weeks (e.g. after the merge
window closes).

Johan
