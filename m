Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEAEF55346D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 16:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351453AbiFUOXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 10:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351375AbiFUOX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 10:23:26 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EB312AC5;
        Tue, 21 Jun 2022 07:23:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 18AF9CE1985;
        Tue, 21 Jun 2022 14:23:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0FBFC3411C;
        Tue, 21 Jun 2022 14:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655821402;
        bh=/7FHu/l1P2AIpjzv1z9rW00tsNnYYhYf7Z3/9CtVBlQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r77Y8UbJMdEM3NMc6q4lW0erRfnRQ+oZlU55aji2tP5hf/74PGWUSvRUhveaAoZMM
         dT4kymsdwPSXz723uWyKJThFv4YEi07+N+OW5JGT2oV436sPZRhAN/obp2A+vT9k6R
         7PuzlLTk7/pa+yFHPfevNuY/HCA1Gtm9pdIddA6c=
Date:   Tue, 21 Jun 2022 16:23:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     hminas@synopsys.com, stern@rowland.harvard.edu,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        amelie.delaunay@foss.st.com
Subject: Re: [PATCH 1/3] usb: host: ohci-platform: add TPL support
Message-ID: <YrHUV2MeCQ0vAnfd@kroah.com>
References: <20220621130506.85424-1-fabrice.gasnier@foss.st.com>
 <20220621130506.85424-2-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621130506.85424-2-fabrice.gasnier@foss.st.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 03:05:04PM +0200, Fabrice Gasnier wrote:
> From: Amelie Delaunay <amelie.delaunay@foss.st.com>
> 
> The TPL support is used to identify targeted devices during EH compliance
> test. The user can add "tpl-support" in the device tree to enable it.

What is "TPL" support?  What is "EH"?

Please spell things out.

thanks,

greg k-h
