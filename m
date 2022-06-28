Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7D155E791
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239269AbiF1PNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 11:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347784AbiF1PMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 11:12:41 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9DD2B1B8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 08:12:39 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id f15so7892560ilj.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 08:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=JzaEdu37BU6MFeE1/EM/VJLnmOMk02l7CYJX8eq4tkc=;
        b=5W9fYv9xxXQNnT83Z6oX7h25LYg0oqB9W8StPHDjlF0UTBAZvKUBQuf5RyaWAogHM/
         bwKrzfnE2Kotpd4d9DpU3+RKbDlKhXyoManLcKvcrzpae3/Q/UP0Gq7n8hYZmvDaPt7a
         aUgG0U+x3tCebwcSKv6k3wRm4Zc1I9H9UD0wJ8Pn7kA4QQ42+FQz10jqx2zsvXthbtsY
         gvD781bxfxOf2eSeUyV4dn3XX4ejs011Wr+p7c2Acgwo7Vh+XADxASARIT7pXu+eEgJM
         926qN1UI/CJM1F6iKiRd9tub4fwwrQApWN3dKeC/yyQJzhqQ20OiUysQAj3LNn9B7Ahl
         LYaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JzaEdu37BU6MFeE1/EM/VJLnmOMk02l7CYJX8eq4tkc=;
        b=fRngXctQ1zwp0pi94FwG4CGNsPuFhm/b83mfyis2MATaeZNNfP14jLFrcCpYyCHAzs
         WMe87MQJqrtMG8yznW8/btsjw/5XTHyq4fEDTX7di8rwxTrmbYp85t8YmbF3uypa4ITo
         wvqGxy/lFmWzR2csYK7B6KFe8mYrfaWnCwMnDCzIgNpLlEIoYvtlgUc21m2nZqdhZisF
         LdW1yaClV83BycWCeSuhzkOmIu2z+0DlP+BApJQdZv+p0uVfir3KRDRqxTAmo2+b8YaA
         6OS09HKa7z67T+KaW49BIuDj0KjUar/pL+8CdoR9iGHxCMbMWXVZNTbuvV5dSKc6O8+a
         QwLw==
X-Gm-Message-State: AJIora/FN2BH1dI8zol1xUtl0hBCsU67Pv+dGZQ1/WI/M5UsDyLP8sdW
        5dbWLsqGE+6Zd1oovWpxsyruow==
X-Google-Smtp-Source: AGRyM1tvJwr478H9/AdS+jVeLts/fnf03jWh2XlqDQQVGCQ+2NyYdjOcRBzHPeyrkvhOWOml6RNn0w==
X-Received: by 2002:a92:1908:0:b0:2d9:2beb:bc61 with SMTP id 8-20020a921908000000b002d92bebbc61mr10823761ilz.245.1656429158963;
        Tue, 28 Jun 2022 08:12:38 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id v17-20020a92c6d1000000b002d52f2f5a97sm5941326ilm.35.2022.06.28.08.12.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 08:12:38 -0700 (PDT)
Message-ID: <6326ffc3-06ea-ba32-6d5b-3aabf778256e@kernel.dk>
Date:   Tue, 28 Jun 2022 09:12:37 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH for-next 7/8] io_uring: add IORING_RECV_MULTISHOT flag
Content-Language: en-US
To:     Dylan Yudaken <dylany@fb.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        io-uring@vger.kernel.org
Cc:     Kernel-team@fb.com, linux-kernel@vger.kernel.org
References: <20220628150228.1379645-1-dylany@fb.com>
 <20220628150228.1379645-8-dylany@fb.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220628150228.1379645-8-dylany@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/22 9:02 AM, Dylan Yudaken wrote:
> Introduce multishot recv flag which will be used for multishot
> recv/recvmsg

I'd fold this with #8.

-- 
Jens Axboe

