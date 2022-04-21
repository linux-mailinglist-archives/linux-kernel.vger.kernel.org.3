Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F204B509983
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386148AbiDUHvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 03:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352769AbiDUHvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:51:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52B3AE55;
        Thu, 21 Apr 2022 00:48:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E8C961B44;
        Thu, 21 Apr 2022 07:48:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 959F4C385A1;
        Thu, 21 Apr 2022 07:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650527296;
        bh=ixyuxCom2Orc6asBvTj9riwHkdKA+KUeXZRGZvp3rJU=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=swfsrhpizpTBJrKSFMo7spId8wE2y3fUPZX0o4ti33C7nbaMsckL5vcrwkvCW9+ea
         5ILwCvJGWsGyOtUqC9L+0F5k/CPVRGRlnnn8F48qY7fQTNi0LKPM58HYIMAjkfu0Ie
         HKYDuUadjoQ23Qb4/fh2bBof4WXta5Eyfk09GpnFU5K5nGKhWwkgj1PT1SC8Am240w
         yYV4N33L48JPtMYteU1CSF/SoeHE9u/ltE9CjLaK7Qji/XriURiNhpIYOOTvlyPnWm
         tuCwzquoACkirRgLXuoDCXjK071PUkm8mtIuuLbeiUeJ/a6bARiDuOH6omKIDRd8LR
         TseCRl7At48jQ==
Date:   Thu, 21 Apr 2022 09:48:13 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Pablo Ceballos <pceballos@google.com>
cc:     benjamin.tissoires@redhat.com, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH] HID: Driver for Google Hangouts Meet Speakermic
In-Reply-To: <20220405183953.2094007-1-pceballos@google.com>
Message-ID: <nycvar.YFH.7.76.2204210947590.30217@cbobk.fhfr.pm>
References: <20220405183953.2094007-1-pceballos@google.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Apr 2022, Pablo Ceballos wrote:

> This driver works around a problem with the HID usage sent by this
> device for the mute button. It prevents key events from being generated
> for that HID usage since they would be incorrect.
> 
> Signed-off-by: Pablo Ceballos <pceballos@google.com>

Applied to hid.git#for-5.19/google. Thanks,

-- 
Jiri Kosina
SUSE Labs

