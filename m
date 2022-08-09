Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5030A58D598
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 10:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241019AbiHIIop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 04:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbiHIIon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 04:44:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA3A6359;
        Tue,  9 Aug 2022 01:44:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3D58AB80B89;
        Tue,  9 Aug 2022 08:44:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FD9FC433D6;
        Tue,  9 Aug 2022 08:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660034679;
        bh=v6x5YSo+MYRPYBb0bdL5D5uuk27k9Q9WDC74TuJhB1A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qZijWVCMpgsqkkZXpzDLO20UsDAhGMmFlg1gZQl2I6rmQkEQhthQa4XiyXcdlHrz/
         W2vUcCiTRDLH7wJImuev3HgCoInRzdLWK6zCXOcyItyoYl5NL172zl6QDqS4Vn1Gqm
         F5yYtwzdr958JrENQwmi/k60xZtTGykR1piBXfgk=
Date:   Tue, 9 Aug 2022 10:44:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Salvatore Bonaccorso <carnil@debian.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Sasha Levin <sashal@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: stable: Document alternative for
 referring upstream commit hash
Message-ID: <YvIecDUYcrW9vVZC@kroah.com>
References: <20220809045543.2049293-1-carnil@debian.org>
 <9046f8b3-2bd7-64c6-5da8-d1c4b935b1e9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9046f8b3-2bd7-64c6-5da8-d1c4b935b1e9@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2022 at 03:30:46PM +0700, Bagas Sanjaya wrote:
> On 8/9/22 11:55, Salvatore Bonaccorso wrote:
> > @@ -97,6 +97,12 @@ text, like this:
> >  
> >      commit <sha1> upstream.
> >  
> > +or alternatively:
> > +
> > +.. code-block:: none
> > +
> > +    [ Upstream commit <sha1> ]
> > +
> 
> Looks OK. Indeed Sasha uses the alternative style.
> 
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

Thanks, I'll queue this up after -rc1 is out.

greg k-h
