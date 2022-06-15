Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59D354CB98
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 16:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346806AbiFOOnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 10:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241863AbiFOOnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 10:43:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDB727CED;
        Wed, 15 Jun 2022 07:43:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4869FB81D92;
        Wed, 15 Jun 2022 14:43:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2355C34115;
        Wed, 15 Jun 2022 14:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655304181;
        bh=vSgsfL4uwzG+LlRaLz2YdEgdogcehd06El7raMuvZlY=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=UlPvWKIBeJqT/Z3qtQwquwATm19OY7sYFZbH2ku8aJ/GvXC8aadsC6Ynuf2m5bf7h
         l4uGCi5iGbcR03jzUhcXD0pb/EeDAw3YEeCh6s2GJ500R7kbhALf6qFjRsY997uUoG
         row+fGz3HN8tumlvoVH2drjW7K9FV4ODqOWxbDE2uT+iePK6CCFcPmWgkxhugbrKwM
         sw50rQd92Bip2nlOq5VWElIa2WUJpBPgjNg0bB3b4NhfkTZUfKq66g6BldgAeY35zH
         3UM5FQw+5YGXgM073SJrQrx6g86yTg1OlcA8pAfPNkKZSpViISYA1Ps480OAthO6o0
         RTexGIdqIyBnA==
Date:   Wed, 15 Jun 2022 16:42:58 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Thomas Schneider <qsx@chaotikum.eu>
cc:     "Daniel J. Ogorchock" <djogorchock@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: nintendo: Set phys property of input device based
 on HID phys
In-Reply-To: <20220611010359.115555-1-qsx@chaotikum.eu>
Message-ID: <nycvar.YFH.7.76.2206151642510.14340@cbobk.fhfr.pm>
References: <20220611010359.115555-1-qsx@chaotikum.eu>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Jun 2022, Thomas Schneider wrote:

> While the MAC address the uniq identifier is set to (cf. commit
> 1425247383c5 ("HID: nintendo: set controller uniq to MAC")) is certainly
> unique, the physical location can be more helpful in user interfaces.  The
> underlying hid_device already provides a suitable value, so we can simply
> reuse this here.
> 
> Signed-off-by: Thomas Schneider <qsx@chaotikum.eu>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

