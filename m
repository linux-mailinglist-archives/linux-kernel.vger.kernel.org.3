Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1EFC5A0B40
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 10:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238566AbiHYIWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 04:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238045AbiHYIWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 04:22:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE29CA5735;
        Thu, 25 Aug 2022 01:22:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2977B61AF6;
        Thu, 25 Aug 2022 08:22:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 799A9C433D7;
        Thu, 25 Aug 2022 08:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661415758;
        bh=uWhj5buhwHMeZlieGDkHSgadBEk4hW4Jr27pvQbKR6E=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=N61kPms6+ktr/YyZuKW+AfohFGERr330rt8HrFv02M+hv2lnFoOXYVGSmTNayDfnP
         qI3mV1qJUM02AATGlCNM0H22dhSOuYfOTjIaJ3uu32pSHgxlsermIEgvCEGS58QBld
         ilLDIoazBi3YsfMzUMJn1AOFxg9eRteTc1OUrl3qtzi678pbjcwHSQ0D0PljeFj95Q
         LUAGUv/fRUL9o4td82X/KaIJYFR6rNtYd0EYGoxar58KRsgIPugTB7F5gbHxX2qcgv
         BYZySJAY9MEdiOSQDgGc39W7v8hLyVsCUQzSkplZqIKzz9E4sSoiWX3TOTdr4Olf3G
         POlMnemo0wctw==
Date:   Thu, 25 Aug 2022 10:22:35 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
cc:     linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH 1/1] HID: steam: Prevent NULL pointer dereference in
 steam_{recv,send}_report
In-Reply-To: <20220708074009.621113-1-lee.jones@linaro.org>
Message-ID: <nycvar.YFH.7.76.2208251022170.19850@cbobk.fhfr.pm>
References: <20220708074009.621113-1-lee.jones@linaro.org>
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

On Fri, 8 Jul 2022, Lee Jones wrote:

> It is possible for a malicious device to forgo submitting a Feature
> Report.  The HID Steam driver presently makes no prevision for this
> and de-references the 'struct hid_report' pointer obtained from the
> HID devices without first checking its validity.  Let's change that.
> 
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Cc: linux-input@vger.kernel.org
> Fixes: c164d6abf3841 ("HID: add driver for Valve Steam Controller")
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Sorry for the delay, I had some time off and things got stalled. Applied 
now, thank you.

-- 
Jiri Kosina
SUSE Labs

