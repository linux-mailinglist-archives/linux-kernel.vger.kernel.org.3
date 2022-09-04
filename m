Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B625AC7F7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 00:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbiIDWYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 18:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbiIDWYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 18:24:11 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AED624949
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 15:24:10 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id cr9so5092296qtb.13
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 15:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=/kpUeenb5nqYR9uiY5au4z4/e0aOEgua/6J3wDQsxC4=;
        b=TsbQx+xbR8tTPoEj9ho/eL9iaYPfErK4zY8w8kf19e54GPxdLOEZ0FlpnsaU3ghzgN
         kAKgjV3xvUMgl3d1l7O5IvFD8J2sPuoT/odr0oSHIDWENmqbGNZWuqueL1Kmv+K5WKZd
         ilz45rH0wYqOzlFtO1gMwfwCmdRgZu4wSnpoFjuPfyq6z9R8FOnUppWVh7YjT1p3UzFr
         Hob7OV35SXMsCw4MRHN8802WAD7BAcTBclU/veThOD2g6m7+56sjPp1UZtIlMmgb2irb
         t2UPt1jBR9E0Veid50y95Q0EcndeGi7A9YhzDYVNnkLce0RvB0w7owOcFP8GEP20xCMX
         8BAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=/kpUeenb5nqYR9uiY5au4z4/e0aOEgua/6J3wDQsxC4=;
        b=3YSdkPTiVcYN842SXknVd68vmXmRcYf++H+8fjL3m/4RudMv2lOhLNReeJSzmowuxm
         kM1Bh3GUkiF4cm3xA1C7SwCmqrcJ0v05UgdZ3OUScOa1Hw4LZiprMnd1/r9Ja+UuNnls
         sTV/Z/xDPExejZ8PKh1pemHEtDqUJtRTuLwG4wyTqgP6A9rhvMXUdQDFq5EmmXUfYBYJ
         jRkn/rkT8O6onyK2wXubuaj9n6AtctezF+wr+r5u3dEA/DM45KaQUjBAylNVAUESo2xW
         49lV9S99YH3mZo5GB+VzadUG7UVC3quiu9fKoJp/PNUDUJInwPyOH1n5qPqmyPrQ6Q9o
         2PXA==
X-Gm-Message-State: ACgBeo3zIuZxifdHfzT8OohfP9sUtYnlW/TAvDXBkodYKRI+Qyq5FSnw
        NK4mGBb2M3+JChpgBgYetW2LjnXcUVjuLNBxUphv5Q==
X-Google-Smtp-Source: AA6agR4RK/SO+JqimtT58kgAeutNnZwB/SJ8+7S0XLiuSfjg999YWS5+L/sVLWXeoRt1p2uHJWdS9/hPVouD7UY+Az8=
X-Received: by 2002:ac8:5acf:0:b0:344:8f3e:5f08 with SMTP id
 d15-20020ac85acf000000b003448f3e5f08mr36545092qtd.207.1662330249330; Sun, 04
 Sep 2022 15:24:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220829125447.268741-1-xu.panda@zte.com.cn>
In-Reply-To: <20220829125447.268741-1-xu.panda@zte.com.cn>
From:   Doug Smythies <dsmythies@telus.net>
Date:   Sun, 4 Sep 2022 15:23:59 -0700
Message-ID: <CAAYoRsUFF=ebThB3gKUw2G1G2HO_HmBXvd-+XiwYtiKpJ41zqw@mail.gmail.com>
Subject: Re: [PATCH linux-next] tools: power: x86: intel_pstate_tracer:
 intel_pstate_tracer: Replace the relative path of the called grep with an
 absolute path
To:     cgel.zte@gmail.com
Cc:     linux-kernel@vger.kernel.org, xu.panda@zte.com.cn,
        ray.huang@amd.com, rafael.j.wysocki@intel.com, Jinzhou.Su@amd.com,
        Zeal Robot <zealci@zte.com.cn>,
        zhanglin <zhang.lin16@zte.com.cn>,
        Doug Smythies <dsmythies@telus.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note: Modifying the address list a little with this reply.

On Mon, Aug 29, 2022 at 5:55 AM <cgel.zte@gmail.com> wrote:
>
> From: xupanda <xu.panda@zte.com.cn>
>
> Using absolute paths when invoking grep can lead to serious security
> issues. A malicious operator may create a new file named grep in the
> PATH before the real grep file. When the program executes and calls
> grep, the fake grep file will be executed, so that the malicious
> operator can execute arbitrary code or even obtain root privileges.
> Using absolute paths when calling grep avoids this problem.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: xupanda <xu.panda@zte.com.cn>
> Reviewed-by: zhanglin <zhang.lin16@zte.com.cn>

Acked-by: Doug Smythies <dsmythies@telus.net>

>
> ---
>  tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> index b46e9eb8f5aa..d6fae6e51d30 100755
> --- a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> +++ b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> @@ -348,8 +348,8 @@ def split_csv(current_max_cpu, cpu_mask):
>      if os.path.exists('cpu.csv'):
>          for index in range(0, current_max_cpu + 1):
>              if cpu_mask[int(index)] != 0:
> -                os.system('grep -m 1 common_cpu cpu.csv > cpu{:0>3}.csv'.format(index))
> -                os.system('grep CPU_{:0>3} cpu.csv >> cpu{:0>3}.csv'.format(index, index))
> +                os.system('/usr/bin/grep -m 1 common_cpu cpu.csv > cpu{:0>3}.csv'.format(index))
> +                os.system('/usr/bin/grep CPU_{:0>3} cpu.csv >> cpu{:0>3}.csv'.format(index, index))
>
>  def fix_ownership(path):
>      """Change the owner of the file to SUDO_UID, if required"""
> --
> 2.25.1
>
