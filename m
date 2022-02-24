Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6804C3946
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 23:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbiBXW4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 17:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbiBXW4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 17:56:54 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C98B20B148;
        Thu, 24 Feb 2022 14:56:23 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id m13-20020a7bca4d000000b00380e379bae2so669886wml.3;
        Thu, 24 Feb 2022 14:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=Zi1b2mViq0hVTmTwxj2JFBkk+1b6GZr054w+Vl7W0GI=;
        b=hBfP3OoJH5NIU7oxbUX/xlrRJFszgcgy9tXwUa9Jg1W9dLdnn6fKKNMnEuoja0+VUg
         yL/ZkH0AJNjWEQRqgEJmPUR17J+CY9/57H98qyaYaR7Qj7Y3yeOz9MfqXcBYZvNCkaJN
         PtK1ShedhwUEb0JBeBBdoTEQuNsucb1M7MXxOvIPHX8BTY3s/UfMLcwGeGYePcPzvPGS
         lYNDCk8Winn8TlGGLwnbZTUaKulvgFM9ik7jg3mNeFsJNeJzEXgdc1wcI7EfFO6F48XO
         E/24FvyqhKg5jZ2y+mliA8fIxMNDaTZkQ8pdJoL3mJrFP7iBWDrKGTrodgWmXJaj5rL9
         N1Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=Zi1b2mViq0hVTmTwxj2JFBkk+1b6GZr054w+Vl7W0GI=;
        b=QXDQo3gdRt2r14h3MvwTeYHgn7kCeiFaDS4EkGaeFUCqJ1VRY124qcrAI0TciyaDIi
         m2rM87MiU2PecEArwTDD+i51ZS8Ta3mFgGAQMKk0q7yiaNKif0LvMchnkSnEMRZfmKWO
         IgH9jJ9t9GVuxFBOiaGBkqa5KZaOKlmLsioEjFd/14bUxUNbsCc5gQkVQGKJhWON1q9E
         tHLwppJay8kcCtU6/bPPtCh65pkdifYWa2MkwnOWOB5wstzrlzlsw5RxgIW01rOf2ypJ
         idkkdrU2EaltXAoaf2JfOSpryPEmYWKiqqvFqHBnkdUI5BJm1535oJu9xItDPhzpE9pl
         RBqw==
X-Gm-Message-State: AOAM530yjeQY63c2tg11vWu2qIJMFLsCYJNAKFWU2e3VTHrX7rxwMpvF
        anxnDsn0dj6ZyDaFilZqazI=
X-Google-Smtp-Source: ABdhPJzifE5j5Kie0K3/9MBfqUuyId1xxJ2IS6Gh/w2ybpj5C+80ta1nN4hCJRc1vQvNT5n1quPILw==
X-Received: by 2002:a05:600c:1e0a:b0:37d:342c:36ac with SMTP id ay10-20020a05600c1e0a00b0037d342c36acmr236481wmb.168.1645743381962;
        Thu, 24 Feb 2022 14:56:21 -0800 (PST)
Received: from [192.168.0.210] (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.googlemail.com with ESMTPSA id x3-20020adfdd83000000b001e58c8de11bsm624367wrl.39.2022.02.24.14.56.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 14:56:21 -0800 (PST)
Message-ID: <69aeef03-69ba-07f4-2506-31e481f86c76@gmail.com>
Date:   Thu, 24 Feb 2022 22:56:20 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        linux-iio@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   "Colin King (gmail)" <colin.i.king@gmail.com>
Subject: re: iio:adc:ad7280a: Move out of staging
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Static analysis with clang scan picked up a potential issue with 
drivers/iio/adc/ad7280a.c in function ad7280a_write_thresh, the analysis 
is as follows:

         switch (chan->type) {
         case IIO_VOLTAGE:
                 value = ((val - 1000) * 100) / 1568; /* LSB 15.68mV */
                 value = clamp(value, 0L, 0xFFL);

                 ^^
Note: variable value is being assigned a value

                 switch (dir) {
                 case IIO_EV_DIR_RISING:
                         addr = AD7280A_CELL_OVERVOLTAGE_REG;
                         ret = ad7280_write(st, AD7280A_DEVADDR_MASTER, 
addr,
                                            1, val);
                         if (ret)
                                 break;
                         st->cell_threshhigh = value;

..and value is being used here ^^

                         break;
                 case IIO_EV_DIR_FALLING:
                         addr = AD7280A_CELL_UNDERVOLTAGE_REG;
                         ret = ad7280_write(st, AD7280A_DEVADDR_MASTER, 
addr,
                                            1, val);
                         if (ret)
                                 break;
                         st->cell_threshlow = value;

and value is being used here ^^

                         break;
                 default:
                         ret = -EINVAL;
                         goto err_unlock;
                 }
                 break;

However for the IIO_TEMP case:

         case IIO_TEMP:
                 value = (val * 10) / 196; /* LSB 19.6mV */
                 value = clamp(value, 0L, 0xFFL);

                 ^^
Note: variable value is being assigned a value

                 switch (dir) {
                 case IIO_EV_DIR_RISING:
                         addr = AD7280A_AUX_ADC_OVERVOLTAGE_REG;
                         ret = ad7280_write(st, AD7280A_DEVADDR_MASTER, 
addr,
                                            1, val);
                         if (ret)
                                 break;
                         st->aux_threshhigh = val;
                                              ^^
But val is being used here rather than value

                         break;
                 case IIO_EV_DIR_FALLING:
                         addr = AD7280A_AUX_ADC_UNDERVOLTAGE_REG;
                         ret = ad7280_write(st, AD7280A_DEVADDR_MASTER, 
addr,
                                            1, val);
                         if (ret)
                                 break;
                         st->aux_threshlow = val;
                                             ^^
and val us being used here rather than value too


So for the IIO_TEMP case either the assignment to value is redundant or 
the setting of st->aux_threshhigh or st->auxthreashlow is incorrect.

Colin
