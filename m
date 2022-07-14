Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B797574B82
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 13:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238614AbiGNLHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 07:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiGNLHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 07:07:19 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FEB6163;
        Thu, 14 Jul 2022 04:07:17 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id z12so2072585wrq.7;
        Thu, 14 Jul 2022 04:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AfpMtZf7diWsPaOpufPn+75l2jzeWCRIIGx5dt42+xw=;
        b=g8XVdvvUflNTnFz93Jw0xk/v418YAtunY5swaQgsfJhK/H1NV0EKH12i9bGo3qDROf
         jfLrjJ8ndOMKrJMCdbJUMk4RZGrXfzCeKOtQ/G2sj9wrMY42qOAT47Z5T8w5k+x3mCq+
         6oM8u6GH8yS0srS9D0SP+jRfKvl3TPmZOUpA1McTFoJoqJ32/e+ASn2FAls4ZMJ3l8lw
         rsUsVm43kbFRy1Z0b9FW2Kg5bPEt+pw0L8wOWHe7H/ClDk4pMkkDtkGM9feRjgc/nyhG
         fEKpT3L3aebMf2QiKtSobRr3m6uHzbxdiLcjPKWf5UCXdZdV5ywBb6idav+aN0EeGvWM
         bm5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AfpMtZf7diWsPaOpufPn+75l2jzeWCRIIGx5dt42+xw=;
        b=GoIiK53oykSVSZ3+PH4k66/vlyXhr2lAplv1ofZgkumHmdiyAgdWHKOmwlFM3qOtdY
         gwbWOatW8AAvytpg6uW4lDbvExatFBxE88r7OOGcIyMHQC2SObFtvN3IfuNdfYWqoaYV
         SRkk+jp9TdCc4EtmSSC4KxoQan2vSjUG2meiXAbQGPwEQ/QBL+0PATqGsBdYlxLS+TAy
         vuWcILKsu3oeZg/SBlcdFF55hoPm/FXimxg84pQC2eRRF4qnn91dINgTvoafXwgvZ7VQ
         YJgwu1xwzABby3fEeSueVgWkyOg2IDBg7+58iHhr8xXr8ojVjhV3fo9xgKd5l7wkfZ3n
         VwBw==
X-Gm-Message-State: AJIora+sMSLQKe6aDwdo1+C9cyOLBxLBouju+x77gztzZuynW0ps6p0I
        njb0hiM3uDzpnymniii5M5IdQWjSu5aa1g==
X-Google-Smtp-Source: AGRyM1shIzJRkqAWkOd6jCYlNSls1WkWkbsiI15Jw2JKocUkiagUUhHj+gMgf2346nJQEtM9shvOfw==
X-Received: by 2002:a05:6000:68f:b0:21d:928e:d0cd with SMTP id bo15-20020a056000068f00b0021d928ed0cdmr7758317wrb.539.1657796835558;
        Thu, 14 Jul 2022 04:07:15 -0700 (PDT)
Received: from debian (host-78-150-47-22.as13285.net. [78.150.47.22])
        by smtp.gmail.com with ESMTPSA id i10-20020adfe48a000000b0021b90cc66a1sm1170581wrm.2.2022.07.14.04.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 04:07:15 -0700 (PDT)
Date:   Thu, 14 Jul 2022 12:07:06 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Jul 14
Message-ID: <Ys/42uMzQy+CFTGI@debian>
References: <20220714185514.7d1a2ac9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714185514.7d1a2ac9@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Thu, Jul 14, 2022 at 06:55:14PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20220713:

Build failures on next-20220714:

csky, xtensa and mips allmodconfig fails with:

drivers/net/wireless/mac80211_hwsim.c: In function 'mac80211_hwsim_tx_frame_nl':
drivers/net/wireless/mac80211_hwsim.c:1431:37: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
 1431 |         info->rate_driver_data[0] = (void *)cookie;
      |                                     ^
cc1: all warnings being treated as errors
make[3]: *** [scripts/Makefile.build:250: drivers/net/wireless/mac80211_hwsim.o] Error 1
make[2]: *** [scripts/Makefile.build:525: drivers/net/wireless] Error 2
make[2]: *** Waiting for unfinished jobs....
drivers/scsi/mpi3mr/mpi3mr_os.c: In function 'mpi3mr_queue_qd_reduction_event':
drivers/scsi/mpi3mr/mpi3mr_os.c:389:40: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
  389 |         *(__le64 *)fwevt->event_data = (__le64)tg;
      |                                        ^
drivers/scsi/mpi3mr/mpi3mr_os.c: In function 'mpi3mr_fwevt_bh':
drivers/scsi/mpi3mr/mpi3mr_os.c:1655:22: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
 1655 |                 tg = (struct mpi3mr_throttle_group_info *)
 
_____________________________________________________________________________________

arm and arm64 allmodconfig fails with:

make[3]: *** No rule to make target 'drivers/pinctrl/sunxi/pinctrl-sun20i-d1.o', needed by 'drivers/pinctrl/sunxi/built-in.a'.  Stop.
 
_____________________________________________________________________________________

x86_64 allmodconfig with clang fails with:

drivers/clk/qcom/gpucc-sm8350.c:111:2: error: initializer element is not a compile-time constant
        gpu_cc_parent,
        ^~~~~~~~~~~~~
drivers/clk/qcom/gpucc-sm8350.c:126:2: error: initializer element is not a compile-time constant
        gpu_cc_parent,
        ^~~~~~~~~~~~~

arch/x86/kernel/cpu/bugs.c:58:21: error: section attribute is specified on redeclared variable [-Werror,-Wsection]
DEFINE_PER_CPU(u64, x86_spec_ctrl_current);
                    ^
./arch/x86/include/asm/nospec-branch.h:283:12: note: previous declaration is here
extern u64 x86_spec_ctrl_current;
_____________________________________________________________________________________



--
Regards
Sudip
