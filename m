Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC7D4DC7D7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 14:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234691AbiCQNsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 09:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234090AbiCQNsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 09:48:12 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A6D1DC9BC
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 06:46:55 -0700 (PDT)
Received: from [192.168.1.101] (unknown [88.235.220.59])
        by gnuweeb.org (Postfix) with ESMTPSA id A0F447E2ED;
        Thu, 17 Mar 2022 13:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1647524814;
        bh=M/QdYvLrITmlbYSMtNvoKw0sEhJpgWZYZaAJMobK+6I=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=BxuvVGDVMeM04jIggq4fkh2Zm32CV3QGt2UljwfJJtFWc5gUMEEPTuAoQJmLtPr8V
         FNCcaTAXjZHSzoiALGy9IqPys9b1IRpy3w4cNGuH5Jz0onvgNpaX7xsTLu0Iu/qlRA
         0qhufGuHiRFEGmTxitHLQ+LivoRgW65or8M0RCgYOs9rNWgKSfmcs/GZFDhpFSBm/b
         upfvRtpH23Hxzug26isPkSFsakYINNpZB9s66nBbcO1ub0JXVEXTc80K3unS2S1eQO
         vK+FQQ7Zq3Z7vqjQTp7fzKrQTAM4QnQNAQufhKAIHs3zhVQANN11XwGXFHjtPjaXwQ
         g1YWgPmGj5wZQ==
Message-ID: <9fa42069edf92d0ca7d64e967e1b9c0030d9a6ec.camel@gnuweeb.org>
Subject: Re: [PATCH] boot install: Partially refactor the logic for
 detecting bootloader
From:   Beru Shinsetsu <windowz414@gnuweeb.org>
To:     Boris Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Date:   Thu, 17 Mar 2022 16:46:48 +0300
In-Reply-To: <221F34C3-C3E0-4401-BEF2-422F11BF8324@alien8.de>
References: <20220316173221.5937-1-windowz414@gnuweeb.org>
         <2E28CA0C-34F2-4985-86CC-B1823AF8D747@alien8.de>
         <7b4f98d92a57af35c927aef6c85373f8eeeab29c.camel@gnuweeb.org>
         <221F34C3-C3E0-4401-BEF2-422F11BF8324@alien8.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-03-17 at 13:42 +0000, Boris Petkov wrote:
> On March 17, 2022 1:16:26 PM UTC, Beru Shinsetsu
> <windowz414@gnuweeb.org> wrote:
> > I guess I had pure luck having this patch seen? xd
> 
> I'm not sure what you mean here??

Eeee it was just a flash of thought, nothing important. ^^;

> > To be honest with you, nothing has changed _just recently_ to cause
> > this error message to come up.
> 
> Well, I saw this on SLE15-SP4 (brand new) yesterday while I haven't
> seen it on previous service packs. So this doesn't look like it has
> been there since 2007. I'll try to debug it when I get a chance.

Hmm alright. Good luck from now! Hope everything goes flawlessly.
-- 
Beru Shinsetsu
