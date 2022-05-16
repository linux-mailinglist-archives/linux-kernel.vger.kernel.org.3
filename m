Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98D5528112
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 11:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238320AbiEPJwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 05:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240813AbiEPJwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 05:52:18 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A78B9FE0
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 02:52:15 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id dk23so27529180ejb.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 02:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:from:to:mime-version
         :content-transfer-encoding;
        bh=7V//p+pJg3i40vEIWQnv8SYaIe6yF+ePgjkLncHpX8A=;
        b=hm++3o3sVBOuO9ThGAFi5UXdpyVTDqU7UibayzAzo3r9rL94paJA8RC998xDifVp2l
         nqeKxGLOe8VqeRNGNQcqJmc0B5uDzI4o0pIO8cuKQ/psaqlSwJO5zIGxKIFwzAIr32DM
         gwvEU1JkqL/hSWW015LubgklF5WeIi3SqUFND/GyGQYha48k/72xFUUK9vnOq1ZP7zht
         BiTKaElstcmlZVC8rNjdGH7uXrEDWWEEtoNr7IcHbx8zufXMIXfWbsKqaOYevrUbT6NN
         5CFh2T+0RVdhDsqJt6uHhcWPuxN0OAQh499BFO57H7rjm5f/sKEd53ryWfYhVuKlEnQo
         1uOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:subject:from:to:mime-version
         :content-transfer-encoding;
        bh=7V//p+pJg3i40vEIWQnv8SYaIe6yF+ePgjkLncHpX8A=;
        b=TKSq3EvKgfFMydrI29VjZG/pqJDbFqAUiI+YyWZ0A6TvK1fJ0GUkJITTQZEU3QJL87
         ywbMHTwQ1QokAQUWlqE8+Iz9n/GFgETRm+VvGWhP8Y66KUXbPa9GBMWtz5IJbMcK+v3l
         URmAME1L+5zBupsD74aNF/HUfVb093kygoNf06xwscYAt3BSoiFv/F/AICFOREQeZflG
         A1eOliXGhE2ODLxpITr7tKxgxqtAPL4LcIjgGrlJOIrOp497ELlQi798hUHiGd5lPzd4
         PWCI+rNmbxmHqhWl9SWZRRKa/EjFWPlSz4cjoI1PVhv3l2Zlk0rjuQq4cyGxUxm+0uX9
         ULrA==
X-Gm-Message-State: AOAM531xP7isvGUDx+hnHMhrJLR3V0oiktbsMLSh29JbSL+KH+NlmswW
        oN/72d7kq/rrVqswK3WqOl+S1wldFUg=
X-Google-Smtp-Source: ABdhPJz5W/bmrTa/whznnPISqS79USz696shgWcHBmxaC/nF57RH8uZJW9rAnK4Xw49VvmVG0MytCg==
X-Received: by 2002:a17:907:9721:b0:6fe:49b5:34fa with SMTP id jg33-20020a170907972100b006fe49b534famr2492052ejc.535.1652694733988;
        Mon, 16 May 2022 02:52:13 -0700 (PDT)
Received: from [127.0.0.1] (91.141.33.167.wireless.dyn.drei.com. [91.141.33.167])
        by smtp.gmail.com with ESMTPSA id n1-20020a05640204c100b0042617ba63basm4895268edw.68.2022.05.16.02.52.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 May 2022 02:52:13 -0700 (PDT)
Message-ID: <3ec0e3e4bcfe8a79b06120b9525bfda4@swift.generated>
Date:   Mon, 16 May 2022 11:52:09 +0200
Subject: AW: laptopcomputer.de
From:   Karl Geringer <ggeringerkarl3@gmail.com>
To:     "" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guten Tag,


laptopcomputer.de wird nicht mehr ben=C3=B6tigt, und des=
halb zur Feilbietung ausgeschrieben.

Ich freue mich auf Ihre Antwort!=


Noch eine erfolgreiche Woche

Karl Geringer
