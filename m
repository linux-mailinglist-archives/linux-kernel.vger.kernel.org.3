Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27A5048BD0F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 03:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348387AbiALCTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 21:19:50 -0500
Received: from hua.moonlit-rail.com ([45.79.167.250]:41424 "EHLO
        hua.moonlit-rail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348090AbiALCTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 21:19:49 -0500
Received: from 209-6-248-230.s2276.c3-0.wrx-ubr1.sbo-wrx.ma.cable.rcncustomer.com ([209.6.248.230] helo=boston.moonlit-rail.com)
        by hua.moonlit-rail.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <bugs-a21@moonlit-rail.com>)
        id 1n7TEn-0004MI-QE;
        Tue, 11 Jan 2022 21:19:45 -0500
Received: from springdale.mc.moonlit-rail.com ([192.168.71.36])
        by boston.moonlit-rail.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <bugs-a21@moonlit-rail.com>)
        id 1n7TEn-0000gg-Hc;
        Tue, 11 Jan 2022 21:19:45 -0500
Message-ID: <65a13d92-93fc-25d2-0009-b7e60f3392c4@moonlit-rail.com>
Date:   Tue, 11 Jan 2022 21:19:45 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v2 0/2] video: A couple of fixes for the vga16fb driver
Content-Language: en-US
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Robinson <pbrobinson@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Borislav Petkov <bp@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20220110095625.278836-1-javierm@redhat.com>
From:   "Kris Karas (Bug reporting)" <bugs-a21@moonlit-rail.com>
In-Reply-To: <20220110095625.278836-1-javierm@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier, Geert, et al,

Javier Martinez Canillas wrote:
> Changes in v2:
> - Make the change only for x86 (Geert Uytterhoeven)
> - Only check the suppported video mode for x86 (Geert Uytterhoeven).

I just updated Bug 215001 to reflect that I have tested this new, V2 
patch against 4 systems, one more than last time - 2 BIOS/VGAC and 2 
UEFI - and it works perfectly on all four.

Thanks, Javier, for the excellent work!
I didn't test with non-X86, but the code appears to bypass the patch on 
non-X86, so should work fine for Geert.

Kris

Tested-By: Kris Karas <bugs-a21@moonlit-rail.com>

