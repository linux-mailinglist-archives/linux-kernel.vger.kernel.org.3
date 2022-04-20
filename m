Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99C9508BE6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 17:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350477AbiDTPS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 11:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238261AbiDTPS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 11:18:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BAE443D8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 08:15:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 787F3B81FC4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 15:15:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AD58C385A1;
        Wed, 20 Apr 2022 15:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650467738;
        bh=s7kJbmHO4oxkSYmU5fDmutKf8GGc1BWHsk8DFVUqsDI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CRJXGImARYU+HNAm1q0eaA8GkeFhjY2BSnH+foEDcFW9Yyais53+e+7qXju5J55DQ
         c7V+G0UDQ89k0bBaMxyECji33PIijivPSB30G668zaqFUyu0B9tbuAHPwIRdGhYY9w
         Hb1NHqdD7rCQdzUFkph4cQLXHV/gCo48lxg3C6rc=
Date:   Wed, 20 Apr 2022 17:15:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jaehee Park <jhpark1013@gmail.com>
Cc:     Alex Elder <elder@ieee.org>, johan@kernel.org, elder@kernel.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v3 2/2] staging: greybus: remove empty callback function
Message-ID: <YmAjliv4DdTY+JvZ@kroah.com>
References: <cover.1649824370.git.jhpark1013@gmail.com>
 <12037ae2502ad7d0311bcdf2178c3d2156293236.1649824370.git.jhpark1013@gmail.com>
 <a4e5c567-63dd-f7de-114b-a357075444a2@ieee.org>
 <20220414200932.GA4147124@jaehee-ThinkPad-X1-Extreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414200932.GA4147124@jaehee-ThinkPad-X1-Extreme>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 04:09:32PM -0400, Jaehee Park wrote:
> On Wed, Apr 13, 2022 at 07:48:03AM -0500, Alex Elder wrote:
> > On 4/12/22 11:38 PM, Jaehee Park wrote:
> > > Remove the optional remove callback for the soc_codec_dev_gbaudio
> > > structure. The only place it is referenced is
> > > snd_soc_component_remove() which is only called if the sound_component
> > > pointer is non-null. The null function pointers here can be optionally
> > > ommitted. When a sound component is registered this way, the remove
> > > callback is optional. We can safely remove the whole gbcodec_remove
> > > function, which used to be an empty function with a void return type.
> > 
> > Now I think your description is a little long...  But that's OK.
> > 
> > This looks good to me.  Thank you for responding to all our
> > feedback.
> > 
> > Reviewed-by: Alex Elder <elder@linaro.org>
> 
> hi Greg, I saw that this was past on to staging-next already. Is it too 
> late to add Alex to the reviewed by? 

Yes, sorry.
