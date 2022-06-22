Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBFDD5546D8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355219AbiFVIgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 04:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355191AbiFVIgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 04:36:21 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9171D38BE9;
        Wed, 22 Jun 2022 01:36:20 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id b12-20020a17090a6acc00b001ec2b181c98so14492107pjm.4;
        Wed, 22 Jun 2022 01:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=GfqsjDBnA9NqFc4n3hU0IVEZHFYA77sBuc7M8HEDFv4=;
        b=SCJ4YnfN0j6VfMY6hCBVf3g+LHXlQtW3TbuoeEPCtIMN6tXD2EgW8J6OrY9p0rjKR7
         +73PbV/YzovsnkWK7y2v0+eFUyhnrkgYs3Y4FO+xXp+m0rSCpfYTPkC2WAI/ovyWQKEt
         +voZrX9kY1ZQyAE41i5WnoqtXqe2r2sCp2i4fHVrwJKetMHh0AYfi/2O2zC7aVzMGXlY
         95fj9LZmhmPIUrX7se4dZjKMxuCDKlTKcGoYodK2PIx2bHylLEx+TOVEnzKDI53FhoIR
         qMbBMHn0bWsXFz57v7ATK8lnAKNTvMJqiFp+iW3iLfLc2o/jEOMi9pBMDUqYLUNtD9xv
         dx0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GfqsjDBnA9NqFc4n3hU0IVEZHFYA77sBuc7M8HEDFv4=;
        b=df4zy3QvnJwYtequomVdZf5Gp6oHP8UL+51CXyrFIifnC0BF/njd4xzlUR6YXKSmzu
         iqxl8BCLZl7Vz4nnijgj2QmZvfSThrACvFZFuI7LLmFq7qAZY3fOBRxHgRbyxOpV7Y8s
         1CHZ0b9jDNNVg9LAVI/fvyZWkpqKM6j9uTCbAAXQox6kmePHJVoY5gvxv6wqtvaIRs3b
         ivOcSzwDwabVo523qOrBgvNWUkpf6cb0PeP6x5oRhrpHk4Dx8Qhu5huKSYpBLW1vUwaR
         6Bl//bR7lWo6eiGwMwJ3SE+V+hSBGHy8RpHYgRTcCyrdsNs0nwSEWAfZA5ywHM21WB0m
         VRKA==
X-Gm-Message-State: AJIora855/iu9XwGJwubzfH3yJOIxzTEqoIPa+h24DVmvV2X69SleQKu
        qLrI6QYuu0EaRPJK/LTCWJA=
X-Google-Smtp-Source: AGRyM1trF/g/qBtoZmunuNjBApWXlmttV6L2+xeXbV9Lz9cPbXDrtpIAPRZpMXtDA4goIIFXG0CqKQ==
X-Received: by 2002:a17:903:240c:b0:169:52d:cd75 with SMTP id e12-20020a170903240c00b00169052dcd75mr31594874plo.12.1655886980080;
        Wed, 22 Jun 2022 01:36:20 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-12.three.co.id. [180.214.233.12])
        by smtp.gmail.com with ESMTPSA id jf20-20020a170903269400b0016a10e0ce17sm8143718plb.151.2022.06.22.01.36.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 01:36:19 -0700 (PDT)
Message-ID: <4c566329-b2ce-80a5-00da-f3048bdbed3e@gmail.com>
Date:   Wed, 22 Jun 2022 15:36:14 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3] Documentation: highmem: Use literal block for code
 example in highmem.h comment
Content-Language: en-US
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220620083649.18172-1-bagasdotme@gmail.com>
 <YrDqJB0J1PT8VlwA@iweiny-desk3>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <YrDqJB0J1PT8VlwA@iweiny-desk3>
Content-Type: text/plain; charset=UTF-8
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

On 6/21/22 04:44, Ira Weiny wrote:

>> Fix these warnings by indenting the code example with literal block
>> indentation and prefixing comments inside the example with C comment
>> symbol (#).
> 
> "//"?
> 
> Frankly I'd just drop "(#)".
> 
> Perhaps:
> 
> ... indentation and making the comments C comments.
> 

Ah! I had overlooked that. Thanks.

-- 
An old man doll... just what I always wanted! - Clara
