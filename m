Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C116152A2C0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 15:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347200AbiEQNJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 09:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235536AbiEQNJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 09:09:33 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F5435267;
        Tue, 17 May 2022 06:09:33 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id A2E9B1F444FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652792971;
        bh=xNlpc1F54muTtr/z6RaIWW7IyIDJ/ccOrpEag1kxRY0=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=KDnZ/Esd0KFmaNmaa2agEpHbzNnQooi2fseRoNXogH+pvDy/sxy4EmcyjYFBrZ/5c
         C1Bx0BJBxy2S+6pCPAScHlJKK2wuVGFaT+dX+jb5Qadmg3AR4zozG2aLIxSy1PCDpW
         6j1/ocxXbpPbpkSVlCc8/8K57nSVbCyKrV5nl9Fc4iy3pHoSMWiwWFqB7x9nO45bLl
         B8ThvCr0NOV5h/U0Tflcsokrydi3VK4V+iJ6f8fUekNXdgWjB6OlelYPzLQpasuWyA
         KmpEiitplMjeySVR61i+RsdclsBaodOEu2Uc1Jwh/J4JLaOpQcrLItsV5rv4Pn3Weu
         d3G5iA4fmtm5A==
Message-ID: <5d148732-c14d-4e96-f8fc-31acc8932534@collabora.com>
Date:   Tue, 17 May 2022 18:09:25 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Cc:     usama.anjum@collabora.com, Tzung-Bi Shih <tzungbi@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the chrome-platform tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Benson Leung <bleung@google.com>,
        Guenter Roeck <groeck@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
References: <20220516213832.19127535@canb.auug.org.au>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20220516213832.19127535@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/16/22 4:38 PM, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the chrome-platform tree, today's linux-next build
> (htmldocs) produced this warning:
> 
> Documentation/ABI/testing/sysfs-driver-chromeos-acpi:2: WARNING: Unexpected indentation.
> Documentation/ABI/testing/sysfs-driver-chromeos-acpi:11: WARNING: Unexpected indentation.
> Documentation/ABI/testing/sysfs-driver-chromeos-acpi:22: WARNING: Unexpected indentation.
> Documentation/ABI/testing/sysfs-driver-chromeos-acpi:56: WARNING: Unexpected indentation.
> 
> Introduced by commit
> 
>   0a4cad9c11ad ("platform/chrome: Add ChromeOS ACPI device driver")
> 
I've found these warnings in local build. But I'm unable to fix them.
Apparently, there doesn't seem any unexpected indentation. This kind of
same warnings have also appeared on some more files before this commit
without any reason.

-- 
Muhammad Usama Anjum
