Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01BF052F078
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 18:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351550AbiETQWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 12:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbiETQWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 12:22:20 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB36B8BFD;
        Fri, 20 May 2022 09:22:19 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id a38so5272727pgl.9;
        Fri, 20 May 2022 09:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=GRvxtBN/C9wxWz5+ZhYYKzs9qnKHSKKBLmyxPMHQAq8=;
        b=EVJShjdj2n3x/Soo5TXuwql9BCI8yhOyZtEgC2M223tHJRBeyW3JfqJKD16yOS8w/y
         KPNdLNFwTdFgpYAJEH3nv7V24ne5X9pD0Jf+vLGi/INcnW3qI9H+YJNeIMOeaJf2tfMh
         hvcFSndNB5EHwzp+uUtL0gBXHvkmp4PzqEHygYmFwkBV7cdjZcuMIp4QYc0YR3cmxnQq
         t8b4jpNaPunP88msk0YHEGupLlzwC4T0r+/e9/mzb310q3xh05Bb7/aMlUGraFcei+LT
         OSfIxVsUvBuYoVjJ6kaks1JWeKxAbcS2WpIxRtPWoK29Ucg28nNhegty33QujELsEFPg
         FjgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GRvxtBN/C9wxWz5+ZhYYKzs9qnKHSKKBLmyxPMHQAq8=;
        b=zhg2ccfvTOOl7jHm+qaeQjyg4gHyczpNSWPPSn+NauKT1g46wybEbOjXZ2vqD7IFDq
         BKiXJr0x+mv56C04iRpLrzdZowNHB1ADeInmlVtnsAahDAESOsNwi/21tQ6QMOCkXqei
         pgpl76XNyv/Q0sXCNjYJn90asK85BwnJ8lZrkx6TcVRY2V5IVnO3mfuNxEpEk2R35AVb
         Dy23imulf8xLDToX79CmS84I7pme09cBpI7bBKTg3yrlZp1R5iEmxMktXWj33oBfYRdl
         +TCCe1FCfbIboGU+59KhtPgv+R4uEuImGW9qPMXOuPY0GFo0iccycglKq40Lo5lwu1Ho
         eUFw==
X-Gm-Message-State: AOAM530ENyl/ORISw3KNtTG6D/YkkAo1ea9BbGTnm0CsLRnlqU/XpUCV
        m30xtE354xX85NHP0HiVDxw=
X-Google-Smtp-Source: ABdhPJzFmTifJ7tfHIGxJCl5NOUo5AyBDgPrIqvsK0LvcAjT6ddjF9aC08Xm+T+kiHe/rfw04fQnDA==
X-Received: by 2002:a05:6a00:114b:b0:4f7:915:3ec3 with SMTP id b11-20020a056a00114b00b004f709153ec3mr11099752pfm.8.1653063739326;
        Fri, 20 May 2022 09:22:19 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id cp19-20020a170902e79300b0015e8d4eb285sm5787012plb.207.2022.05.20.09.22.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 09:22:18 -0700 (PDT)
Message-ID: <912a5d2b-bc2d-677a-dd64-d66046fc734d@gmail.com>
Date:   Fri, 20 May 2022 09:22:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 1/1] perf vendors events arm64: Update Cortex A57/A72
Content-Language: en-US
To:     Nick Forrington <nick.forrington@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     John Garry <john.garry@huawei.com>, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        linux-arm-kernel@lists.infradead.org
References: <20220517135805.313184-1-nick.forrington@arm.com>
 <20220517135805.313184-2-nick.forrington@arm.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220517135805.313184-2-nick.forrington@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/17/2022 6:58 AM, Nick Forrington wrote:
> Categorise and add missing PMU events for Cortex-A57/A72, based on:
> https://github.com/ARM-software/data/blob/master/pmu/cortex-a57.json
> https://github.com/ARM-software/data/blob/master/pmu/cortex-a72.json
> 
> These contain the same events, and are based on the Arm Technical
> Reference Manuals for Cortex-A57 and Cortex-A72.
> 
> Signed-off-by: Nick Forrington <nick.forrington@arm.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
