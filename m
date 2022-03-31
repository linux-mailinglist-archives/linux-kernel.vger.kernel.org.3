Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7BBA4ED8AE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 13:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235110AbiCaLqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 07:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235275AbiCaLq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 07:46:26 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC4E20826E;
        Thu, 31 Mar 2022 04:44:39 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id s11so21738271pfu.13;
        Thu, 31 Mar 2022 04:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=LqhDZuJaNJExg2VbnXlWCRZCk4FonU0BDi79M0pNs1Y=;
        b=a6w2jv0j2IXRlMA//J2ZPX5zjw/iXkppXRq2fKn/qS8pSuRYMsyjoCL+nv/nI9iAwD
         N05hjD3IhkfxgHzuA698es7oPx2BStKmYMj60ly7yidR7KxB2neoJnlS9LGQBaDgqCoL
         MBxNC55jtG1C8fOjS8esl4UTQaA5YDXYWmWSSn1BvsXJNoHrZeL7E0eD97K3HTCki8qB
         ciM73YG3g1YVlz/CpKlRhnQ6swh5Z7kKOdOqbaG6cnmS/bHRzg5YokctD5gCsPDpx+8j
         4r0GaPfu4L7ZqZPeqUrHsZNayHgwg4cRILMVbGm39YSXO4+IGWkPHV6W95959WMdOTWc
         r83w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LqhDZuJaNJExg2VbnXlWCRZCk4FonU0BDi79M0pNs1Y=;
        b=4bwK3aZUcs6KbrRWkLARfre+TrW7wPerniezK298q4iM1Ms80KreU2ToCopxzl5E/K
         yMcqAz9EjT8NqYkoUNE5s+AguCyTw7D1Z1x0/JOz/VySf7Oa1AmmJj0OOaDBdbkcd4tj
         zKdLd0bHkfonfUGQUJ6QjhX1w9WckfPYBgLDoCV6e/qNc2uvsYrNoevdf6Wp7SNO2bfH
         FoT6W3W4spl6n4zhMt7xamrN7r8h/2Sjmfokq9Oz2MYXFQsodWA3N0mHDY5yxUy5QPCF
         Gyym8zy5t2DmsZXWojV27jFZp/4GqXPXsoW4NZHgKVCi3zPsMFYchYCg/IZCTxeS7q2b
         fjdw==
X-Gm-Message-State: AOAM533lcof8J44BdIDx2rhFXanJIW1ohUk2t+BoRdyf+PzzCabpigz9
        SiQmmL92TykeLYZUtBHmpDjA8KAjy5WtbHgd
X-Google-Smtp-Source: ABdhPJxswSNI4AFf4/OrTS5MowKZtDxmx8p8EIyMB33KcexfRHfuEpizNXIuzy6WINO1d1YmWjQJsQ==
X-Received: by 2002:a63:ec47:0:b0:382:692a:dc04 with SMTP id r7-20020a63ec47000000b00382692adc04mr10417542pgj.352.1648727078998;
        Thu, 31 Mar 2022 04:44:38 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-30.three.co.id. [180.214.232.30])
        by smtp.gmail.com with ESMTPSA id t15-20020a63b70f000000b00381510608e9sm22520962pgf.14.2022.03.31.04.44.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 04:44:38 -0700 (PDT)
Message-ID: <a4f42004-7c99-8c4e-259b-903254501529@gmail.com>
Date:   Thu, 31 Mar 2022 18:44:31 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v5] mm/vmstat: add events for ksm cow
Content-Language: en-US
To:     cgel.zte@gmail.com, akpm@linux-foundation.org, david@redhat.com,
        willy@infradead.org
Cc:     corbet@lwn.net, yang.yang29@zte.com.cn, yang.shi@linux.alibaba.com,
        dave.hansen@linux.intel.com, saravanand@fb.com, minchan@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, jhubbard@nvidia.com,
        xu xin <xu.xin16@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>
References: <20220331035616.2390805-1-yang.yang29@zte.com.cn>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220331035616.2390805-1-yang.yang29@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/03/22 10.56, cgel.zte@gmail.com wrote:
> +Monitoring KSM events
> +=====================
> +
> +There are some counters in /proc/vmstat that may be used to monitor KSM events.
> +KSM might help save memory, it's a tradeoff by may suffering delay on KSM COW
> +or on swapping in copy. Those events could help users evaluate whether or how
> +to use KSM. For example, if cow_ksm increases too fast, user may decrease the
> +range of madvise(, , MADV_MERGEABLE).
> +

Did you mean "tradeoff between possible delay on KSM COW and swapping
in copy"?

-- 
An old man doll... just what I always wanted! - Clara
