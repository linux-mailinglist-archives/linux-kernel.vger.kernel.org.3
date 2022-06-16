Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8BA54D718
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 03:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356170AbiFPBdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 21:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355476AbiFPBdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 21:33:38 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFAC57173;
        Wed, 15 Jun 2022 18:33:32 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id e9so159490pju.5;
        Wed, 15 Jun 2022 18:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=JkG7sUC11qpO15GX2zgwuQatsRPoDK80WEYSGtvU0cc=;
        b=SENhJLb3UINlfc4VxpO8fXotQfKm1gYqofD3Je8z5PJTU1uoQKZYn56GDd6SyAdFxH
         7e5cinr8MGZuawsixCSXzkTyQOqiRXlXBO6/dHm6xjMiTrYFeUxPZxaf2+ONsZrXym9w
         MOHlKw/0eCICQ8GwxaNmQ6GT3PEFkVE8LtIuJx00jKeeAzymHUSqvBW7OZt75vlgEfz6
         kRw8hnA+/mRI1TfZwCsQf4fZzfpFxA/oh2xaFqocnbfVk9WXpo5twRp6VfXMl8Qg48aa
         gOCDS/oEUBmhpANpT7HfadjnvlKGgXDnFLbPSQZTowZJqqRHSyITV3B540vegpkVoY9i
         ICug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=JkG7sUC11qpO15GX2zgwuQatsRPoDK80WEYSGtvU0cc=;
        b=FaWo69/Q9toXRZD95JcAiYQNQzHv61VXIW8hYwMgSv27AzcWj+f0gcx/Gm21Kj35Nx
         WfMeHGSTyGWGlwnTVl4/FPnY/pwGnZKqoSWljY6HsH2Syri3KMoEAWjP0EIXLnr3D2e+
         wqdbs6LyMNLBEKqaL1N0ovoPhB6ZuZ5wzY4/aFDkhtW0dkRy3sIPltN8QzHU0vVBD2P0
         IF1dm8qRPAUm9Brhi4pKBbvlvWeRC1uZPtUVW9lrevdlAj61pPJDa4NKqzW5tZV1sq0p
         FpInSXlHTZtKUMSi39vmvQuRKr7GglYxq4dxplehE5kb64BCXVOJlHoGTM949n5kWG8u
         hBZQ==
X-Gm-Message-State: AJIora+Kzto5xic83L6AsNiorPAPmYcXtX3TxuUQ8adVCfVepBLutVHF
        chOo8uo3mUfHcdSSljUH2Ew=
X-Google-Smtp-Source: AGRyM1srqYqkoHBsOg4aXL8dqDAorIp5AvtAlhCtihs0Y4iO9o+FGA8DWOKcs0kAd7Z7HgGTZSFARw==
X-Received: by 2002:a17:902:ba8d:b0:168:ff8f:c1f with SMTP id k13-20020a170902ba8d00b00168ff8f0c1fmr2119481pls.6.1655343212351;
        Wed, 15 Jun 2022 18:33:32 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-50.three.co.id. [116.206.12.50])
        by smtp.gmail.com with ESMTPSA id w22-20020a1709026f1600b001676f87473fsm247025plk.302.2022.06.15.18.33.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 18:33:31 -0700 (PDT)
Message-ID: <5111ed70-3dbd-ef51-82ff-aa83bf9c58a3@gmail.com>
Date:   Thu, 16 Jun 2022 08:33:27 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] Documentation: highmem: Use literal block for
 *kmap_local_folio() example
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220615101509.516520-1-bagasdotme@gmail.com>
 <YqnyJ/5/ZLiNI+5v@iweiny-server> <YqnyiuaeQz6aSNUL@iweiny-server>
 <62074230-52d9-83b7-df64-c00aea016150@gmail.com>
In-Reply-To: <62074230-52d9-83b7-df64-c00aea016150@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/22 08:31, Bagas Sanjaya wrote:
> My bad too...
> 
> I forget editing patch subject. I guess the subject and description could
> just say "code example in *kmap_local_folio() comment" somewhere.
> 
> Willy, what do you think? Any suggestion?
> 

Ah, I don't see Willy's reply.

-- 
An old man doll... just what I always wanted! - Clara
