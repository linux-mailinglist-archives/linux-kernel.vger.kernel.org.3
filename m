Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2ACE54C553
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 12:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244463AbiFOKCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 06:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239791AbiFOKCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 06:02:47 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC15D140C4;
        Wed, 15 Jun 2022 03:02:46 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id w21so11042620pfc.0;
        Wed, 15 Jun 2022 03:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=nteK1qoCay2RhFt0DlIAYFn4vHPFXwhUd6je8LRTjPE=;
        b=RLlVrgW4T25qth6/+VgsHVrLCoHQtSoE1jY3pnqi5aE1m9I8k7YeAbHdCF2m2sOMp3
         23nHvbjazPBH95VFNhZymmmuSSn0a0+BoJ+bL1kIY9BOsFX6XUDR8laQs+1Wu7WBjWSY
         LHSeBdzi/Y9fqPahnHoHJ5SaCx7QkLkqx3McM7FvaTnTD7Cv4CFB0xwROWVq6POXgW8S
         3uITF/D/EElMYE9lF30Dr1rXTxDsBvsRqEl+TImPBbi0t6rKiPZo2FS92Tj6NXifYxvZ
         d1yYAbLeNmlOU1ksh2UsfqYdHiFOAUPlZBnLMLjGSVLKtR0tn3vIaz4duIyw+bUdQ+H8
         zN0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nteK1qoCay2RhFt0DlIAYFn4vHPFXwhUd6je8LRTjPE=;
        b=G83vQO3dXjIvYFuHIRJKCpRDeCTUu5huWfYAwc5VwDWAfOFlS13elhDb3dTok8ShZe
         auUJ7NvxmEQeth2CnreBBeKGsI3OCdZov5J/ViIZssHxks7/YQCWQY4jhG6V3lGnHfmQ
         HAzBz5WZDn0VahIOTsWUCDccqBs70Kyyl345wu+Mi/a1pZyZrwuKS9924+65ffg8ZSEy
         VdpC4ZPfPXLpz3hKrIMMgpQJ1bqU7mPVNUd5ldvxcFrnCGgx+WyHZ0uh5e+QKtypFv2Q
         5l8BDG6b6sDUjm6ym68D3HtyJFu41fKl+Dcz9y8MwHPbFdCIlSXUhFPfinOaooifOwXT
         q2sA==
X-Gm-Message-State: AOAM5307HPSpULsFCRBK8q/XeJFFvomHCrb7p1qJCmguLsHDUlPvi03l
        Ftt55vWAhXijg6eMm973xhw=
X-Google-Smtp-Source: AGRyM1uAN5RM+oZ+AAxAzi49nd/seaDjdy/NVDH1i30rF+2qIlAAdW+vdvPJtW1w+Pur1AVTDL6oZQ==
X-Received: by 2002:a05:6a00:996:b0:50b:76b8:3bb1 with SMTP id u22-20020a056a00099600b0050b76b83bb1mr8902904pfg.9.1655287366226;
        Wed, 15 Jun 2022 03:02:46 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-70.three.co.id. [180.214.233.70])
        by smtp.gmail.com with ESMTPSA id h129-20020a636c87000000b004052d642b6dsm8189933pgc.9.2022.06.15.03.02.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 03:02:45 -0700 (PDT)
Message-ID: <a1479ae5-9f27-f808-95f9-0ce53a662057@gmail.com>
Date:   Wed, 15 Jun 2022 17:02:41 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] Documentation: highmem: Use literal block for
 *kmap_local_folio() example
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220614123115.522131-1-bagasdotme@gmail.com>
 <YqiIRONzn5t1v8yq@casper.infradead.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <YqiIRONzn5t1v8yq@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/22 20:08, Matthew Wilcox wrote:
> On Tue, Jun 14, 2022 at 07:31:16PM +0700, Bagas Sanjaya wrote:
>> These warnings above are due to comments in code example of
>> *kmap_local_folio() are enclosed by double dash (--) instead of prefixed
>> with comment symbol (#).
> 
> That's clearly the code example for kmap_atomic(), not
> kmap_local_folio().
> 

Ah! I don't see void *vaddr that make use of kmap_atomic(). Thanks
for reminding.

-- 
An old man doll... just what I always wanted! - Clara
