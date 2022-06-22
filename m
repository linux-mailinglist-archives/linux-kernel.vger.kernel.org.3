Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51AC9554B3C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 15:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357585AbiFVNZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 09:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357031AbiFVNX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 09:23:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F072FFEC;
        Wed, 22 Jun 2022 06:23:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25EC4B81ED4;
        Wed, 22 Jun 2022 13:23:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D10BFC341C5;
        Wed, 22 Jun 2022 13:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655904197;
        bh=5pW9uFPMMRuVXKfUDNR4jaro/yLiJGQx0iXWkH4qaek=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tWjO5rOsf9fenY8xqmU1m30lqhwPzNSn6SIZhjNFAxtUztorKyU0WKSa8rB2ISQ34
         /BueaJrZBOgij+QzPf2gv2+hiNyS88NzsQBgQ2yRXGMJhJ4u8ci41vQNDFYp/q6VnS
         vg1dlIyrJE02Z58pn1R5HHExMr2vRXvWu8sEsqA2sv9FdsK2CNMdGbkPZ01kj0bVua
         ERQaknF/XgkY9bM85gliNmSgH51uSzlm+/r6AKVlJ5aoSYdRoIPniiHCkLIdNzs8Cz
         QgAvSXcWI3gVg2RHcbKbOtWZuzpiqXy65CcS5BGqVcrzggWYdyMqrnmqBTG93lufI/
         qTBwEuWx5S7HA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o40KA-0006M6-6m; Wed, 22 Jun 2022 15:23:14 +0200
Date:   Wed, 22 Jun 2022 15:23:14 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Kushagra Verma <kushagra765@outlook.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: serial: ark3116: Fix bare use of 'unsigned'
 checkpatch warning
Message-ID: <YrMXws0UuIs1HhZG@hovoldconsulting.com>
References: <HK0PR01MB2801789671F56BDA8DA12A83F8B29@HK0PR01MB2801.apcprd01.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HK0PR01MB2801789671F56BDA8DA12A83F8B29@HK0PR01MB2801.apcprd01.prod.exchangelabs.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 06:47:50PM +0530, Kushagra Verma wrote:
> Fixes the bare use of 'unsigned' checkpatch warning by changing 'unsigned'
> to 'unsigned int'.

This is not something that needs "fixing" and you should not run
checkpatch.pl on code that's already in the tree unless you're trying to
learn how to create patches by working in drivers/staging.

Johan
