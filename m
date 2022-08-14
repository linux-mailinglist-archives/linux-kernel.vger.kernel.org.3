Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F83592648
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 22:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbiHNUKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 16:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiHNUKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 16:10:54 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006CFDECC;
        Sun, 14 Aug 2022 13:10:52 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id e28so4344956qts.1;
        Sun, 14 Aug 2022 13:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=PdBi5OuwXZBNv/tLu4ATxSdR53rLFwXiKyPLTOcyCqs=;
        b=nhHLHbtQebeVnoRo9MGAHwxSasWeh19rym0oAIjVcamb2/tJQTNbv4RWr1EEiv/HcI
         3kKVe1qmtVcnxdtdzouO0b6/KWzYZ5G1WZRVfHZBQHfKPFcNh7b3K6sU4navnIoPIMpj
         0hZLehYrIk0Twny8uFfIQ8CEHVdfWV4sVi+HgeexC8SSrRheTMfnlrPu6J0Nh4K3lJM9
         mpkNXxx7WKfDq070SvJFxzTBIN4eX7pacnDD4v+RAAaUFcl6H12g8LUFuVpgO6Wn6/Qv
         6hJc+8f4lvwgx0/j+6n9tZxma/+MQkp8aEVqrK6hvFqdw95MxBLReZuDAHziYwheCIkH
         twNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=PdBi5OuwXZBNv/tLu4ATxSdR53rLFwXiKyPLTOcyCqs=;
        b=khGYaAgF7MovCy+lGXf5lK7Aes9hJ1o/i8Os16Z7EL1A3XH6/50p0uFc/6Z5HTqjl3
         E9iOdxUs+FTs2Mjv8mQ4YPJ1RLvLwtayluhrBR6fAjpGvKeLj4Vrp6pb+W0TRR6fHEw3
         lHWxW5qiBjCboWh5FoN67WQcKmWispFEHX3UXNWK/HsO8Wl2XS3hZW08nHh4J1BzdEjm
         59a6gn5jBKkWrf4VlmshH4or2eI1YbiTjoFrPOgog780+duPTblbF1lbkvR4AVXN0FrF
         rC3yQGFDCl9oT8MbFYfhJY3s2SByOMlLgUal1woRkDiHIUOFQGbVPiqsALLUykf9s7D7
         +LwA==
X-Gm-Message-State: ACgBeo0i4DMYoNeBRIe5P3xx4sZLQca+G/GbxRTty3WsovlzGHB5geTf
        /q2pDbHizC8oiLUTDagQGbYvN+AgOwb0QTahxagkh5Ac
X-Google-Smtp-Source: AA6agR7k/yRXcmyZE7m3KdQ3G+/pKjUMVEK45ZgqNnENWIQJFBqaPgAvohrkY4BIhXTmMJTFFUIAbW8nFKICe/S0BsE=
X-Received: by 2002:a05:622a:40a:b0:343:77ba:727f with SMTP id
 n10-20020a05622a040a00b0034377ba727fmr9796008qtx.481.1660507852099; Sun, 14
 Aug 2022 13:10:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220814170016.479976-1-martin@kaiser.cx>
In-Reply-To: <20220814170016.479976-1-martin@kaiser.cx>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 14 Aug 2022 23:10:16 +0300
Message-ID: <CAHp75Ve7muGtouxm2uMmmgvw1bUkkxxj_5AKaVJ5HrTxSbnEbQ@mail.gmail.com>
Subject: Re: [PATCH] iio: potentiometer: max5432: use KBUILD_MODNAME as driver name
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 14, 2022 at 8:15 PM Martin Kaiser <martin@kaiser.cx> wrote:
>
> KBUILD_MODNAME evaulates to "max5432". Replace the hard coded driver name

evaluates

> with KBUILD_MODNAME.

NAK from me on the basis that this is (a loose) part of an ABI and if
somebody relies on it, renaming the module will break this.

-- 
With Best Regards,
Andy Shevchenko
