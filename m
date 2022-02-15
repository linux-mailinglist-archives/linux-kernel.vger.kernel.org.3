Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855AD4B62CF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 06:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbiBOFbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 00:31:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234160AbiBOFa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 00:30:56 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EADC128DC8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 21:30:23 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JyV6N1Ss1z4y3m;
        Tue, 15 Feb 2022 16:30:20 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     rdunlap@infradead.org, paulus@samba.org, mpe@ellerman.id.au,
        benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210320213932.22697-1-unixbhaskar@gmail.com>
References: <20210320213932.22697-1-unixbhaskar@gmail.com>
Subject: Re: [PATCH] powerpc: epapr: A typo fix
Message-Id: <164490279633.270256.14303800612164733087.b4-ty@ellerman.id.au>
Date:   Tue, 15 Feb 2022 16:26:36 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Mar 2021 03:09:32 +0530, Bhaskar Chowdhury wrote:
> s/parmeters/parameters/
> 
> 

Applied to powerpc/next.

[1/1] powerpc: epapr: A typo fix
      https://git.kernel.org/powerpc/c/a1c414093370ed50e5b952d96d4ae775c7a18420

cheers
