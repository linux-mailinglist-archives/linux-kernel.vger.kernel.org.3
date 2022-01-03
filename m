Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 650374837EB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 21:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbiACUJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 15:09:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiACUJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 15:09:48 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7112C061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 12:09:47 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id q5so41610176ioj.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 12:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ryYB5jKGadEi0k933ngWy9k9HXsrzqsuK+74anPVy+Y=;
        b=e0LdmUWEFlFDIS7VFBnOjOv+beidhw43TT/BVOWnH9ZyBSKgB9IW9EMGAskNprZYLA
         Qa2r7RL4MghwsBrzf6S7encDq8Mjtajl9vQ3XiHcYzQ7OwLFtXT1kannH70PvBB5U768
         X/YuIjT9PRET35IncI27JUE5VDyEJIeb0e5suhqN3Y6OHtzawJmb3DTEQN3octl0QZvM
         7Fl+rSj3yZ3YB1odWNTN2t+Nv49BhqtWjBrR+eXkADbMgi2J9QBuhTCEpPE6K5TAgtZA
         y7AGY7A0/ccz2GD59gQj6N7VZG6YdhdhywJRBjbBJku/cqi/nSnvEnsWRzW0x0gtaONS
         0lsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=ryYB5jKGadEi0k933ngWy9k9HXsrzqsuK+74anPVy+Y=;
        b=gWhtyrovm6dzsuhv30fn/Cf6LjILSKYppNuvlMVR9+lsIFuUvfxmNydRoZsRtsO5uC
         VhyAiumLmNahB2io71xnMVj85r/gqYog0ySmVksoN1J+Aejd4IlfjefjHtsX+Qc43rTd
         dxZqSbPIycyXZieAwLlxys0FZXU6Nmhp8HLwqCAhHmEFFxCKjzS4HEbXsaVCUf2FLNHP
         mrnqiI8dpvpzLBaGd/XumUb39G+GeYGGGwUrdFtXfC2ifFcC/Wh/bl/DwoT2mt9zB5/h
         3QV4g9QbIMHw5c0rNKTaZWD1wjrVcrFnL4gWY3fAZSGdUp8CuWfk3czkbQ7GVPrL23Kw
         +tRw==
X-Gm-Message-State: AOAM530un7hp/OAeFw7H7Lp5YNAxDxNBKaZ93bVbri/rT7tg8kSK63rs
        O1oO32nwxP48ywSHMowlEaJdR7kQxeq/52Mgs44=
X-Google-Smtp-Source: ABdhPJzQTjAJpY+IohXsq6+Lb0I2oEsGXG64+VyDUXP60hZ22fFQRZb80Og8CcEpTw7f9Cqc1MtTXOYZV8goGUYmoo4=
X-Received: by 2002:a5d:9d1a:: with SMTP id j26mr21742148ioj.145.1641240587234;
 Mon, 03 Jan 2022 12:09:47 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6e02:19c5:0:0:0:0 with HTTP; Mon, 3 Jan 2022 12:09:46
 -0800 (PST)
Reply-To: mstheresaheidi8@gmail.com
From:   Ms Theresa Heidi <kumarbestamit@gmail.com>
Date:   Mon, 3 Jan 2022 20:09:46 +0000
Message-ID: <CALGifAGTn27amQLkK49WXGG3ff1Q8UK2gVQrKPZaXZszwgsURA@mail.gmail.com>
Subject: =?UTF-8?B?55eF6Zmi44GL44KJ44Gu57eK5oCl44Gu5Yqp44GR?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

6Kaq5oSb44Gq44KL5oSb44GZ44KL5Lq644CBDQoNCuaFiOWWhOWvhOS7mOOBk+OBruaJi+e0meOB
jOOBguOBquOBn+OBq+mpmuOBjeOBqOOBl+OBpuadpeOCi+OBi+OCguOBl+OCjOOBquOBhOOBk+OB
qOOBr+eiuuOBi+OBp+OBmeOAgeazqOaEj+a3seOBj+iqreOCk+OBp+OBj+OBoOOBleOBhOOAguen
geOBr+OBguOBquOBn+OBruaPtOWKqeOCkuW/heimgeOBqOOBl+OBpuOBhOOCi+mWk+OBq+engeea
hOOBquaknOe0ouOCkumAmuOBl+OBpuOBguOBquOBn+OBrumbu+WtkOODoeODvOODq+OBrumAo+e1
oeWFiOOBq+WHuuOBj+OCj+OBl+OBvuOBl+OBn+OAguengeOBr+W/g+OBi+OCieaCsuOBl+OBv+OC
kui+vOOCgeOBpuOBk+OBruODoeODvOODq+OCkuabuOOBhOOBpuOBhOOBvuOBmeOAguOCpOODs+OC
v+ODvOODjeODg+ODiOOBjOS7iuOBp+OCguacgOmAn+OBruOCs+ODn+ODpeODi+OCseODvOOCt+OD
p+ODs+aJi+auteOBp+OBguOCi+OBn+OCgeOAgeOCpOODs+OCv+ODvOODjeODg+ODiOOCkuS7i+OB
l+OBpuOBguOBquOBn+OBq+mAo+e1oeOBmeOCi+OBk+OBqOOCkumBuOaKnuOBl+OBvuOBl+OBn+OA
gg0KDQrnp4Hjga7lkI3liY3jga/jg4bjg6zjgrXjg7vjg4/jgqTjgrjlpKvkurrjgafjgZnjgILn
p4Hjga/jg5Xjg6njg7Pjgrnlh7rouqvjgafjgZnjgILnj77lnKjjgIHjgZPjgZPjgqTjgrnjg6nj
gqjjg6vjga7np4Hnq4vnl4XpmaLjgavogrrjgYzjgpPjga7ntZDmnpzjgajjgZfjgablhaXpmaLj
gZfjgabjgYTjgb7jgZnjgILnp4Hjga82Muats+OBp+OAgee0hDTlubTliY3jgIHnp4Hjga7mrbvl
vozjgZnjgZDjgavogrrjgYzjgpPjgajoqLrmlq3jgZXjgozjgb7jgZfjgZ/jgILlvbzjgYzlg43j
gYTjgZ/jgZnjgbnjgabjgpLnp4HjgavmrovjgZfjgabjgY/jgozjgZ/lpKvjgILnp4Hjga/jgZPj
gZPjga7nl4XpmaLjgafjg6njg4Pjg5fjg4jjg4Pjg5fjgpLmjIHjgaPjgabjgYrjgorjgIHjgZ3j
gZPjgafogrrjgYzjgpPjga7msrvnmYLjgpLlj5fjgZHjgabjgYTjgb7jgZnjgILkuqHjgY/jgarj
gaPjgZ/lpKvjgYvjgonlj5fjgZHntpnjgYTjgaDos4fph5Hjga/jgIHnt4/poY0yNTDkuIfjg4nj
g6vvvIgyLDUwMCwwMDDnsbPjg4njg6vvvInjgZfjgYvjgYLjgorjgb7jgZvjgpPjgILku4rjgafj
ga/jgIHkurrnlJ/jga7ntYLjgo/jgorjgavov5HjgaXjgYTjgabjgYTjgovjgZPjgajjga/mmI7j
gonjgYvjgafjgIHjgoLjgYbjgZPjga7jgYrph5Hjga/lv4XopoHjgarjgYTjgajmgJ3jgYTjgb7j
gZnjgILnp4Hjga7ljLvogIXjga/jgIHnp4HjgYzogrrjgYzjgpPjga7llY/poYzjga7jgZ/jgoHj
gasx5bm06ZaT44Gv57aa44GL44Gq44GE44GT44Go44KS55CG6Kej44GV44Gb44Gm44GP44KM44G+
44GX44Gf44CCDQoNCuOBk+OBruOBiumHkeOBr+OBvuOBoOWkluWbveOBrumKgOihjOOBq+OBguOC
iuOAgee1jOWWtuiAheOBr+engeOCkuacrOW9k+OBruaJgOacieiAheOBqOOBl+OBpuOAgeOBiumH
keOCkuWPl+OBkeWPluOCi+OBn+OCgeOBq+WJjeOBq+WHuuOBpuadpeOCi+OBi+OAgeeXheawl+OB
ruOBn+OCgeOBq+adpeOCi+OBk+OBqOOBjOOBp+OBjeOBquOBhOOBruOBp+iqsOOBi+OBq+engeOB
q+S7o+OCj+OBo+OBpuWPl+OBkeWPluOCi+OBn+OCgeOBruaJv+iqjeabuOOCkueZuuihjOOBmeOC
i+OCiOOBhuOBq+abuOOBhOOBn+OAgumKgOihjOOBruihjOWLleOBq+WkseaVl+OBmeOCi+OBqOOA
geOBneOCjOOCkumVt+OBj+e2reaMgeOBl+OBn+OBn+OCgeOBq+izh+mHkeOBjOayoeWPjuOBleOC
jOOCi+WPr+iDveaAp+OBjOOBguOCiuOBvuOBmeOAgg0KDQrnp4HjgYzlpJblm73jga7pioDooYzj
gYvjgonjgZPjga7jgYrph5HjgpLlvJXjgY3lh7rjgZnjga7jgpLmiYvkvJ3jgaPjgabjgY/jgozj
govjgYvjgoLjgZfjgozjgarjgYTjgIHjgZ3jgZfjgaboiIjlkbPjgYzjgYLjgozjgbDjgIHnp4Hj
ga/jgYLjgarjgZ/jgavpgKPntaHjgZnjgovjgZPjgajjgavmsbrjgoHjgb7jgZfjgZ/jgILnp4Hj
gavkvZXjgYvjgYzotbfjgZPjgovliY3jgavjgIHjgZPjgozjgonjga7kv6HoqJfln7rph5HjgpLo
qqDlrp/jgavmibHjgaPjgabjgbvjgZfjgYTjgILjgZPjgozjga/nm5fjgb7jgozjgZ/jgYrph5Hj
gafjga/jgarjgY/jgIHlrozlhajjgarms5XnmoToqLzmi6DjgYzjgYLjgozjgbAxMDDvvIXjg6rj
grnjgq/jgYzjgarjgYTjgajjgYTjgYbljbHpmbrjga/jgYLjgorjgb7jgZvjgpPjgIINCg0K56eB
44Gv44GC44Gq44Gf44Gr44GC44Gq44Gf44Gu5YCL5Lq655qE44Gq5L2/55So44Gu44Gf44KB44Gr
57eP44GK6YeR44GuNDXvvIXjgpLlj5bjgorjgIHjgYrph5Hjga41Ne+8heOBjOaFiOWWhOS6i+al
reOBq+S9v+OCj+OCjOOCi+OBk+OBqOOCkuacm+OCk+OBp+OBhOOBvuOBmeOAguengeOBruacgOW+
jOOBrumhmOOBhOOCkuWNseOBhuOBj+OBmeOCi+OCguOBruOBr+S9leOCguacm+OCk+OBp+OBhOOB
quOBhOOBruOBp+OAgeengeOBruW/g+OBrumhmOOBhOOCkuWun+ePvuOBmeOCi+OBn+OCgeOBq+OA
geOBk+OBruWVj+mhjOOBq+WvvuOBmeOCi+OBguOBquOBn+OBruacgOWkp+mZkOOBruS/oemgvOOB
qOWuiOenmOe+qeWLmeOBq+aEn+isneOBl+OBvuOBmeOAguOCueODkeODoOOBp+OBk+OBruaJi+e0
meOCkuWPl+OBkeWPluOBo+OBn+WgtOWQiOOBr+OAgeeUs+OBl+ios+OBguOCiuOBvuOBm+OCk+OA
guOBk+OBruWbveOBp+OBruacgOi/keOBruaOpee2muOCqOODqeODvOOBjOWOn+WboOOBp+OBmeOA
gg0KDQrjgYLjgarjgZ/jga7mnIDmhJvjga7lprnjgIINCuODhuODrOOCteODj+OCpOOCuOWkq+S6
ug0K
