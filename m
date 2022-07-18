Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8135786DC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 18:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbiGRQAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 12:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiGRQAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 12:00:17 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A01DF3A
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 09:00:17 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id r9so20092090lfp.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 09:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=5/k+xQ+hzF8cEyBxOe1yjY6RPmm4sF+YjCMfGP2Q0Yw=;
        b=TAhrPlKYCCrI6hok/zWt0hFYIXukzjrnCn7ceynulzT/3X95m+PiD+Dl1NV9ZWnQWo
         svzPuyyuNO+DU1trWi5QROejysGprwcA6qg0PeSmHQQOPCkic0i3klQeNO9Fdlca3cRg
         GecGGWM/kBzorC8Y4mTuq2qEg0iTbw+mzF9f8MxUDqOd6gsbc7WBq+3hhIBrk1BFMHdj
         x7psdp7DA7PBjy2gxJ+dul+2HiadcMGEHkLzDqi8+e1JValrEP3vtS2QX/mPmKRvC4BS
         fV/ixaWp5wI+lv+StfvIRvQvvbu56TE5dw7j3Yvy0Bb8rkBaR1oeshU3g7pQaWEIAwvj
         WaIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=5/k+xQ+hzF8cEyBxOe1yjY6RPmm4sF+YjCMfGP2Q0Yw=;
        b=yPR56WXy8mE0k5ufOsVVa90XbrfGO71NF9n8SRkx5u6rhUba48suBvDVUXD+6fBPNt
         Y3X94Wo2N0HqIbPGhFPR3CEJ+60//v87iIjKgUrz41ywav2bIJkr9WlehqqirfmuL0fI
         2C1e9zeC5MM2t6InjTs+zkfzPLBdoVOpPRs97Nw3an7LQiqGsf7/ERdjSge9Hf4hC9MY
         l49P3x7of8Q+7C1XXhAZpq/Z3vCMxdP9nGgEh6/mUduyJ9r0sz9yawTtcP9htNT6+9/F
         iWqY7Q/3I188Ux8yObsOIJihkrl6etvAwz5BvPBI9N6iGw/TrThpavPH09Me7OXskupH
         FLDQ==
X-Gm-Message-State: AJIora9WADDc1/+zT8gPQPCbmkEiyb6fyi67gKETgj0+UVsPpR5tutIN
        YahEjArPuC8sIZYFccu6gxYQXY+DDdhqHt1xiyE=
X-Google-Smtp-Source: AGRyM1sf9E2vfQFET75C5zxzOWsnhUZcwYeCpMr4ToPL/rtxnj9m+kwWwmfOaWRmI5t8lGN8P7/6SHg2t9exu8pfJDo=
X-Received: by 2002:a05:6512:308c:b0:48a:22a5:f3d0 with SMTP id
 z12-20020a056512308c00b0048a22a5f3d0mr9067109lfd.494.1658160015044; Mon, 18
 Jul 2022 09:00:15 -0700 (PDT)
MIME-Version: 1.0
From:   Lily Wil <lilywilrtup@gmail.com>
Date:   Mon, 18 Jul 2022 21:30:04 +0530
Message-ID: <CANuHmkya-cXFH8EkbJvXk-b972t_zzdawNhTe1QAN3WTMLvtdg@mail.gmail.com>
Subject: Hello please check the order
To:     paypalhelp4766@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Member,


Thank You for choosing Paypal for placing your Order BITCOIN.

 Your order has been successfully placed.

 The Payment will be shown soon within next 5 to 10 hours on PAYPAL

 PRODUCT INFORMATION

Memo Id                                : OSIYSY98987SNKS

Item Name                              :  BITCOIN (BTC)

Order Placed Date                      :  18th July 2022
Receiving Date                            :  Day After Place The Order.
Price                                            :  289.65 USD
Mode of payment                        :   PYPL INC

 If you Wish to Cancel then please feel free to contact our Billing
Department as soon as Possible.

You can reach us on +1 ( 8 8 8 ) - ( 5 4 0 ) - ( 4 9 8 0 )


Regards,

Paypal Billing Department
