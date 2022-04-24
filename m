Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A0F50D392
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 18:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235726AbiDXQmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 12:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235664AbiDXQl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 12:41:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186CE13BD69;
        Sun, 24 Apr 2022 09:38:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B262D61135;
        Sun, 24 Apr 2022 16:38:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D742C385AD;
        Sun, 24 Apr 2022 16:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650818336;
        bh=CwRTXxLo3F+1aQhEPT+wAMGo5heYkKH9HOW0ofhMpSs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pBvjGafMLmvsmrHakweLWivvm+TGGr7aswWYYk8FTU1ymE5U2ewQx8F7Z0r/sm+zi
         UKhV0Vp1H35qmjjRHZjEQMbuit777kQrDkvWPYJ/Amu65FqbKq/at/A+mDVpIBSs1C
         VZT44sjSD+ISIGy5/aQMjZ9jcKXUej2plYL70UUBLb0akNgjsdRYwTMoCFjnLKkcTg
         hYN6TXVRaQFTKHvR8Zntrj/QglKe7Up+KKYAgrbjzEeWwN2pySPkQ4466VsCLTujpl
         ZYQAjPDUNMkXFg1GODFT/663wpvPYHjSN0ehyQCzclxpbicILTTqlrXcgx+fmWVMVE
         riDRAYa2s+EHQ==
Received: by mail-pl1-f178.google.com with SMTP id n18so21949615plg.5;
        Sun, 24 Apr 2022 09:38:56 -0700 (PDT)
X-Gm-Message-State: AOAM530ADWP9KrtpeH/AmAaizv7ugtQxrOyQ4ZDNp/369fXOYFe7hGZS
        SHuzkbKCy75n9+FmkbIhZ/EGOtxmSDRCc5p54XQ=
X-Google-Smtp-Source: ABdhPJxVJ/mEosTAXWAwfHFeBu0LrV7oSxHszej8XtyJL0/TIz7ZDsC2zcj7NyN24092D6xvAcd7BBXGfW/qgYpKDUQ=
X-Received: by 2002:a17:902:6ac7:b0:150:24d6:b2ee with SMTP id
 i7-20020a1709026ac700b0015024d6b2eemr14386856plt.168.1650818335628; Sun, 24
 Apr 2022 09:38:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220401214032.3738095-1-michael@walle.cc> <20220401214032.3738095-4-michael@walle.cc>
 <8d9e41b5-a143-eace-72ff-c8e9e399daba@roeck-us.net>
In-Reply-To: <8d9e41b5-a143-eace-72ff-c8e9e399daba@roeck-us.net>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Sun, 24 Apr 2022 18:38:44 +0200
X-Gmail-Original-Message-ID: <CAJKOXPeBq62VELj5Qxph3DuS_i2zpfhN7bnpwy5LogBDGXHp1Q@mail.gmail.com>
Message-ID: <CAJKOXPeBq62VELj5Qxph3DuS_i2zpfhN7bnpwy5LogBDGXHp1Q@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] dt-bindings: hwmon: add Microchip LAN966x bindings
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Michael Walle <michael@walle.cc>, Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Apr 2022 at 18:37, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 4/1/22 14:40, Michael Walle wrote:
> > Add a binding for the temperature sensor and the fan controller on the
> > Microchip LAN966x family.
> >
> > Signed-off-by: Michael Walle <michael@walle.cc>
> > Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> Still needs approval by a devicetree maintainer.

You already have it :)
https://www.kernel.org/doc/html/latest/process/maintainers.html#open-firmware-and-flattened-device-tree-bindings

Best regards,
Krzysztof
