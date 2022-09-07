Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0875B062B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 16:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbiIGOMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 10:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiIGOM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 10:12:28 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD325725A
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 07:12:26 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id i77so11552436ioa.7
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 07:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=XLm2FS4jato4lheGsNY4LowY5TrnyAyqeiZDY4H2/yM=;
        b=5MKSEGVBkug8VZmE0BjiTtziIZRjpAip/BCo9UCoKKGsa6AHBcXLO3X3etSiSHYAk9
         dD55ixrjONSFhVKfUwMmzyry5F68fD8aCiCMX09lBYqWKcA6qWwGpO/jC2xBf1tLw+qH
         NJeYHhXLepPDT6Nx2a8QebU6YNqJxl8eW4zA1A2VncL2eT6VnCIJWDuaufe/65ehEEe3
         v8zdTvZb1QV234MvnorE8cTh+fD8ocHbn+m0cz9zusacYRxWQXYA/AR95BX1HiPznUsx
         x0GoIdwDBA8a+azN4G5unS1EpJu8QpxyrSkbtWRcIBlrKUksIUd+MkTqtE71ad6soHh3
         riDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=XLm2FS4jato4lheGsNY4LowY5TrnyAyqeiZDY4H2/yM=;
        b=KyEZwFykLtZ4Xp/eQ2FPdHdY5pUkyOL/Q+3IqIxzRz6JGPg3M1O4vIUT4GCU3z8Wyk
         J1ZRFiQ4kputKDBVjrXEbmlJmlfJS2YgVGGTpVq5w34B4o4sAowaPOnfyBjKw/pN91A3
         SJWxa5ziDriuRcgNWRNc6Ug7itTJmlpbCxQaxj0NB1WF5J7k/JlzSWpjrtZSMxfG2A9V
         2HPX2bdLeDpNbt1sWCAS6FEOB9c12+V9pagD43FZrqtcQkchxHvHVyKXB4Ly5amKql67
         +TCC1YkZZPMOUdOt6lIHdtKk8IRjCGGWwfsBV3S3exHUhLw89BWJddUJ9BO59bo+lH3n
         LZxQ==
X-Gm-Message-State: ACgBeo0H5sVLNZn6yvHPc3OFfXLmzYNU1THRgJEsTb605hHyccoXt+c/
        QqtSaHqSvhl8ui4wEZ8TkffbjJO7OVfACg==
X-Google-Smtp-Source: AA6agR6OBEe6T0vcnaHnxzvoaMZck9XBTuq4bd8R0W64zMzEoTYU/Lawb92RtwF512h9lab1lkc8pg==
X-Received: by 2002:a02:294a:0:b0:349:fb9e:b5e0 with SMTP id p71-20020a02294a000000b00349fb9eb5e0mr2247160jap.115.1662559944962;
        Wed, 07 Sep 2022 07:12:24 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id o3-20020a027403000000b0034f36a43ec8sm6796219jac.78.2022.09.07.07.12.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 07:12:24 -0700 (PDT)
Message-ID: <d4a8f2a4-b662-19c2-f3ad-cc27fcd5211c@kernel.dk>
Date:   Wed, 7 Sep 2022 08:12:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] kernel: export task_work_add
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
References: <20220829040013.549212-1-ming.lei@redhat.com>
 <5a1b3716-bcf8-8c37-2bd5-44e885de1f48@acm.org>
 <2d4655d4-2510-eb1e-2e4d-9d910e823293@kernel.dk>
 <20220907140550.GA21414@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220907140550.GA21414@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/22 8:05 AM, Christoph Hellwig wrote:
> On Wed, Sep 07, 2022 at 07:44:05AM -0600, Jens Axboe wrote:
>> On the patch itself, it definitely makes sense in the context of ublk.
>> My hesitation is mostly around not really wanting to export this to
>> generic modular users. It's OK for core interfaces, of which ublk is
>> on the way to becoming, but I really don't like the idea of random
>> modules using it. But that's not really something we can manage with
>> the export, it's either exported or it's not...
> 
> Yes, I'm really worried about folks doing stupid things with it.
> Thinking of the whole loop saga..

Exactly. But we don't really have any tools outside of clearly marking
it as such. It's not like we have an EXPORT_MODULE_CORE_GPL() and with
that requiring a driver or modular kernel feature that marks the module
as MODULE_IS_CORE_GPL().

-- 
Jens Axboe
