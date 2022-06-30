Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAA6560F68
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 05:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbiF3DDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 23:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiF3DDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 23:03:32 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85B92FFC8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 20:03:31 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id g4so10270055pgc.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 20:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=eFrmibnOmK8XtuM6Tf2P09vssNYtvI09arlKksnBKmE=;
        b=gh082DJ/aYAWrrxFP3fklYYjtIoW+j/NN4MkEMRnj4P4EZJNZUvCVpg+Zc2sAZiNln
         HkviLYrDCvJA2USF4UphbxO4twsOAgYkmU4Uq0063yklzyZZen9dI5QYtjT+2vqiZUuR
         2kH0TwJGGzem1LZ8vtMUD5kT8RYrX6U6sEtBrgnv2jWWxm3nrPF2qoQ/YHgH5Rr69+A+
         OnBuOt78XCgmfOi8JSbbvmwaz67r5STd9pRHYkxzBQtzBOxlJineMGCRRUfY0V7fjeXp
         0GdMPB2QQRtSM14x8tiaq/JmtPC5F+hjcDaXDGAyxQR+mFladnfaQ2xKWQORA463rSl8
         5xUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eFrmibnOmK8XtuM6Tf2P09vssNYtvI09arlKksnBKmE=;
        b=UyHW79pAXEgPxKv7FVohFcLN+h6hn6EMo80tDz2rKnsf5AcSfjljLmSdyloqEkq19L
         sS75eQlJqFYYv7HQo2ODKmFdvINuBKZXIXsCKMJTbLaojmuijEAeRgig55wJzRTvD9gD
         Q96tgx+y3fVUaz5pVLY5CeOO4uocF2jXg/IasP6DbkE9rDGgA2qt8E9WmC4IHh96Dp+j
         qqN7zu0dgpxC+tSgjRT1+dQ9S/+/sgcrQJ65LWnZBo5U8uqlSBRx5U5sGi+lK72DPthv
         nZU5Q+TQM+wF/+gm5CagA4qXnfxpR7XCQkwpOTOLiLimn95T1Sk9ec4SDjMIOn8rwAWu
         xTrQ==
X-Gm-Message-State: AJIora8W/KdYk4nxUsROnN19zVO10mEOPaiiQRezO5DNZi+Yn2q+sit7
        VlUx2UpEKbGTTRbK4i2nKl4GEg==
X-Google-Smtp-Source: AGRyM1uZFnWsWDxmIxiqvexAY7Zh4+0DiY9yIDIzUAJE34QykecHZzGWoUwHktqumn/9aK+e4vJsUQ==
X-Received: by 2002:a05:6a00:168a:b0:4f7:e161:83cd with SMTP id k10-20020a056a00168a00b004f7e16183cdmr13470004pfc.56.1656558211129;
        Wed, 29 Jun 2022 20:03:31 -0700 (PDT)
Received: from [192.168.123.227] ([122.255.60.245])
        by smtp.gmail.com with ESMTPSA id e13-20020aa7824d000000b0052527e3c5easm12224285pfn.87.2022.06.29.20.03.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 20:03:30 -0700 (PDT)
Message-ID: <fc510255-4813-6b96-f5e5-de4e591a9e7b@linaro.org>
Date:   Thu, 30 Jun 2022 08:33:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: qemu-system-s390x hang in tcg
Content-Language: en-US
To:     Sven Schnelle <svens@linux.ibm.com>,
        =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yu Zhao <yuzhao@google.com>, Juergen Gross <jgross@suse.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Andreas Krebbel <krebbel@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
        qemu-s390x@nongnu.org
References: <20220426150616.3937571-24-Liam.Howlett@oracle.com>
 <20220428201947.GA1912192@roeck-us.net>
 <20220429003841.cx7uenepca22qbdl@revolver>
 <20220428181621.636487e753422ad0faf09bd6@linux-foundation.org>
 <20220502001358.s2azy37zcc27vgdb@revolver>
 <20220501172412.50268e7b217d0963293e7314@linux-foundation.org>
 <Ym+v4lfU5IyxkGc4@osiris> <20220502133050.kuy2kjkzv6msokeb@revolver>
 <YnAn3FI9aVCi/xKd@osiris> <YnGHJ7oroqF+v1u+@osiris>
 <20220503215520.qpaukvjq55o7qwu3@revolver>
 <60a3bc3f-5cd6-79ac-a7a8-4ecc3d7fd3db@linux.ibm.com>
 <15f5f8d6-dc92-d491-d455-dd6b22b34bc3@redhat.com>
 <yt9d5ykkhrvv.fsf_-_@linux.ibm.com> <87pmirj3aq.fsf@linaro.org>
 <yt9dbkubhhna.fsf@linux.ibm.com>
From:   Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <yt9dbkubhhna.fsf@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/29/22 16:16, Sven Schnelle wrote:
> Thanks, that was very helpful. I added debugging and it turned out
> that the TB is left because of a pending irq. The code then calls
> s390_cpu_exec_interrupt:
> 
> bool s390_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
> {
>      if (interrupt_request & CPU_INTERRUPT_HARD) {
>          S390CPU *cpu = S390_CPU(cs);
>          CPUS390XState *env = &cpu->env;
> 
>          if (env->ex_value) {
>              /* Execution of the target insn is indivisible from
>                 the parent EXECUTE insn.  */
>              return false;
>          }
>          if (s390_cpu_has_int(cpu)) {
>              s390_cpu_do_interrupt(cs);
>              return true;
>          }
>          if (env->psw.mask & PSW_MASK_WAIT) {
>              /* Woken up because of a floating interrupt but it has already
>               * been delivered. Go back to sleep. */
>              cpu_interrupt(CPU(cpu), CPU_INTERRUPT_HALT);
>          }
>      }
>      return false;
> }
> 
> Note the 'if (env->ex_value) { }' check. It looks like this function
> just returns false in case tcg is executing an EX instruction. After
> that the information that the TB should be exited because of an
> interrupt is gone. So the TB's are never exited again, although the
> interrupt wasn't handled. At least that's my assumption now, if i'm
> wrong please tell me.

Ah, yes, I see.

We wanted to treat ex_value != 0 as if interrupts are disabled, because we have no way of 
stacking that value for re-execution after the interrupt (which itself could use EXECUTE).

One solution might be to zap ex_value and arrange to re-execute the EXECUTE instruction 
after the interrupt.

Another solution is to generate an exit from any TB translating ex_value, so that 
interrupts are re-examined.  This is probably cleanest.  I'll prepare a patch.


r~
