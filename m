Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362225A0CF0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 11:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240593AbiHYJpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 05:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240556AbiHYJpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 05:45:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BB0A98EC;
        Thu, 25 Aug 2022 02:45:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8410061C12;
        Thu, 25 Aug 2022 09:45:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4173C433D6;
        Thu, 25 Aug 2022 09:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661420741;
        bh=fJxognZHd8CymIKscJO21iln9kDmRQD5RAhBjB2ssPQ=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=GCVKMDU+CMqPMnPhFCWdxlqAkCiOOK683eBW+Aymp14W8Io70CU+2D+9bt1pXHvFm
         oEK5BtTREwBbfmS7UjzvJG6jPynVMNKLY+Y5hWZ4hyBsURwBe7e7VbPyeXVvIOugD+
         T4bcvjfpZsRZbi2nyFw0z6q00UZMhDE5/fuKLOIAAm2eeHenlovu2VkZfjJAzYbabE
         G98AMJwhXHLVy8+lnhhFvJq/k3t+DkLh86LpJng9aEL6bFcA5XEm8p2gy3OQ1XNeMX
         wMfpWmG9jeiBmP5KIBOb3YfSNQAEpbxqohdqNv8mfoPgvjYSt6H5xwufouR8hsE4bp
         cOHNB/Dwp7ucQ==
Date:   Thu, 25 Aug 2022 11:45:38 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Steev Klimaszewski <steev@kali.org>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: hid-input: add Lenov Yoga C630 battery quirk
In-Reply-To: <20220819023924.3272-1-steev@kali.org>
Message-ID: <nycvar.YFH.7.76.2208251145240.19850@cbobk.fhfr.pm>
References: <20220819023924.3272-1-steev@kali.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Aug 2022, Steev Klimaszewski wrote:

> Similar to the Surface Go devices, the Elantech touchscreen/digitizer in
> the Lenovo Yoga C630 mistakenly reports the battery of the stylus, and
> always reports an empty battery.
> 
> Apply the HID_BATTERY_QUIRK_IGNORE quirk to ignore this battery and
> prevent the erroneous low battery warnings.

I've fixed the typo in patch subject and applied, thanks.

-- 
Jiri Kosina
SUSE Labs

