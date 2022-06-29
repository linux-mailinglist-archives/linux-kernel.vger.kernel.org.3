Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2AC855FF02
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 13:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbiF2LsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 07:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233339AbiF2LsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 07:48:01 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576CB3F896
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 04:48:00 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id z41so3256383ede.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 04:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=n64Wrl9PS2CDxAR0FG32fG0S2JSs2ok87bqXX/36PsM=;
        b=Sb8LDImMZ/xGa0cJsbUO+XsQ/5TW/UCx6leqFDGjqs6h3wPvuWBNEn/3D89623+Eo4
         /ZC6oc5BbPr8IXqtgQ3uvZQ3gKwAlAEijEBEgYINR7/2ReB+raE/8VwpImEe6HgNPFMx
         7SnFrYnfVOsDjFHfBDFCbZmsLZcgZuVS5J0bye2vSgJQNbJlrH9opDUWF6V8RsTSh3U9
         2we1pqotvTE5VKBHSB5e9mZfdSabMbO4Xu8G1wrTDQ6LpAlgPw6Rdjq+5k2JPdG9wsOQ
         7dCVjQGDUfYe3NYgdWNnkFx4mpPGDMHS8c5JC5Kc9SmsD3tnKnVAFVM/J6m/LFMKPm94
         dUQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=n64Wrl9PS2CDxAR0FG32fG0S2JSs2ok87bqXX/36PsM=;
        b=q0JQBficN5mhDb7OIOi5/gAcqGe2rqNgd3OW565Ja953pREh0hDTCPKKtYg2L0hFGg
         tm8qkWDKHdWrL4nrxybaDh/G1l0viAcOEA4vJUGzE/L0Z+VFmLyZgkc++gHpxMo3lJSs
         XlfXG2nj7ZiY8V0PzeKA6F1TVinuXB3vtQN4dorJviSos6UhZZWE9jip6x3AhW4LAP3w
         w63s4bczbcHiihBliScJqpFgObaDNiLEzTQlo2sBWH69VGENslEAw2j3wG7IAF10jtmo
         ujnfhUpXtgfm/3yBPMnHQgGFeWpVk0y9358dkuYWp7eQZ06Fs6Mc8lSug+uw/9gn3/rv
         IwXw==
X-Gm-Message-State: AJIora/yJiNtqvvBWdiwMiyUJTGduf4DzyFh8AdTwdLJgxrhRTT0PdtX
        Ti3fwgJxUHSwdiJZTIPvYnh2mXTQpRdW+yfHeSg=
X-Google-Smtp-Source: AGRyM1vhUuosNWWBn9k3Lr+x4oIxVevCaikTbIi9Kt6V0H1tElEhvbj3OoJH5c+9MeU0vesZQyJ0XGhb9DMMhLluc+k=
X-Received: by 2002:a05:6402:51ce:b0:436:7dfc:4840 with SMTP id
 r14-20020a05640251ce00b004367dfc4840mr3771548edd.338.1656503278784; Wed, 29
 Jun 2022 04:47:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6f02:501:b0:1e:ac73:c829 with HTTP; Wed, 29 Jun 2022
 04:47:57 -0700 (PDT)
Reply-To: roselinekim01@gmail.com
From:   Roseline Kim <ozorkwueemma@gmail.com>
Date:   Wed, 29 Jun 2022 04:47:57 -0700
Message-ID: <CALjgLPJY+gkkH4GPSivJQ9Qj4oSbpBAV4CSXWk5akrwmV7wunw@mail.gmail.com>
Subject: Mrs Roseline Kim
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good day.
I am Mrs Roseline Kim from Philippines. my dear, would you be able to handle
a project for us? Please contact me on
for more details.

Thanks

Mrs Roseline Kim
